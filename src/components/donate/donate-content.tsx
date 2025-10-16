

'use client';

import { Button } from '@/components/ui/button';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Progress } from '@/components/ui/progress';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { Heart, Loader2, BookOpen, ShoppingBag, Armchair, IndianRupee, Sparkles, Star } from 'lucide-react';
import { useRazorpay } from '@/hooks/use-razorpay';
import { useToast } from '@/hooks/use-toast';
import { useState, useEffect } from 'react';
import { Input } from '../ui/input';
import { useAuth } from '@/hooks/use-auth';
import { cn } from '@/lib/utils';
import { ScrollArea } from '../ui/scroll-area';
import { useRouter } from 'next/navigation';
import Link from 'next/link';

const impactCards = [
    { title: "Shared Notes", description: "Keep the knowledge flowing with free access to notes.", icon: BookOpen, href: "/notes" },
    { title: "Marketplace", description: "Enable students to buy and sell without platform fees.", icon: ShoppingBag, href: "/marketplace" },
    { title: "Library Booking", description: "Ensure seamless access to campus study spaces.", icon: Armchair, href: "/booking" },
];

const donationTiers = [
    { amount: 50, title: "📖 Knowledge Giver" },
    { amount: 100, title: "✨ Campus Hero" },
    { amount: 250, title: "🔥 UniNest Champion" },
];

const medalColors = ["text-amber-400", "text-slate-400", "text-amber-700"];

type Donor = {
    name: string | null;
    avatar: string | null;
    amount: number;
    userId: string;
}

type DonateContentProps = {
    initialDonors: Donor[];
    initialGoal: number;
    initialRaised: number;
}

export default function DonateContent({ initialDonors, initialGoal, initialRaised }: DonateContentProps) {
  const router = useRouter();
  const { openCheckout, isLoaded } = useRazorpay();
  const { toast } = useToast();
  const { user, supabase } = useAuth();
  const [isDonating, setIsDonating] = useState(false);
  const [donors, setDonors] = useState<Donor[]>(initialDonors);
  const [goalAmount] = useState(initialGoal);
  const [raisedAmount, setRaisedAmount] = useState(initialRaised);
  const [donationAmount, setDonationAmount] = useState('100');

  useEffect(() => {
    if (!supabase) return;
    
    const channel = supabase
      .channel('public:donations')
      .on('postgres_changes', { event: 'INSERT', schema: 'public', table: 'donations' }, async (payload) => {
          const newDonation = payload.new as { user_id: string; amount: number; };

          // Fetch profile for the new donation
          const { data: profileData } = await supabase
            .from('profiles')
            .select('full_name, avatar_url')
            .eq('id', newDonation.user_id)
            .single();

          setRaisedAmount(prev => prev + newDonation.amount);

          const newDonorInfo = {
              name: profileData?.full_name || 'Anonymous',
              avatar: profileData?.avatar_url,
              amount: newDonation.amount,
              userId: newDonation.user_id,
          };

          setDonors(prevDonors => {
              const existingDonorIndex = prevDonors.findIndex(d => d.userId === newDonorInfo.userId);
              let updatedDonors;
              if (existingDonorIndex > -1) {
                  updatedDonors = [...prevDonors];
                  updatedDonors[existingDonorIndex].amount += newDonation.amount;
              } else {
                  updatedDonors = [...prevDonors, newDonorInfo];
              }
              return updatedDonors.sort((a,b) => b.amount - a.amount);
          });
      })
      .subscribe();

    return () => {
        supabase.removeChannel(channel);
    }
  }, [supabase]);

  const progressPercentage = goalAmount > 0 ? Math.min((raisedAmount / goalAmount) * 100, 100) : 0;
  
  const handlePaymentSuccess = async (paymentResponse: any, accessToken: string) => {
    const amount = parseInt(donationAmount, 10);
    const verificationResponse = await fetch('/api/verify-payment', {
        method: 'POST',
        headers: { 
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${accessToken}`, // Pass the token here
        },
        body: JSON.stringify({
            orderId: paymentResponse.razorpay_order_id,
            razorpay_payment_id: paymentResponse.razorpay_payment_id,
            razorpay_signature: paymentResponse.razorpay_signature,
            type: 'donation',
            amount: amount,
        })
    });

    const result = await verificationResponse.json();
    setIsDonating(false);

    if (!verificationResponse.ok) {
         toast({ variant: 'destructive', title: 'Error Saving Donation', description: result.error || 'Your donation was processed, but we failed to record it. Please contact support.'});
    } else {
        router.push(`/donate/thank-you?amount=${amount}`);
    }
  }
  
  const handleDonate = async (amountStr: string) => {
    if (!user) {
      toast({ variant: 'destructive', title: 'Login Required', description: 'Please log in to donate.' });
      return;
    }
    const amount = parseInt(amountStr, 10);
    if (isNaN(amount) || amount <= 0) {
      toast({ variant: 'destructive', title: 'Invalid Amount', description: 'Please enter a valid donation amount.' });
      return;
    }
    setIsDonating(true);
    try {
      const response = await fetch('/api/create-order', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ amount: amount * 100, currency: 'INR' }),
      });
      
      const order = await response.json();
      if (!response.ok) throw new Error(order.error || 'Failed to create order');

      const options = {
        key: process.env.NEXT_PUBLIC_RAZORPAY_KEY_ID, 
        amount: order.amount,
        currency: order.currency,
        name: 'UniNest Donation',
        description: 'Support student innovation!',
        order_id: order.id,
        handler: handlePaymentSuccess,
        prefill: { name: user?.user_metadata?.full_name || '', email: user?.email || '' },
        notes: { type: 'donation', userId: user?.id },
        theme: { color: '#1B365D' },
         modal: {
            ondismiss: () => setIsDonating(false),
        },
      };
      openCheckout(options);
    } catch (error) {
        console.error(error);
        toast({ variant: 'destructive', title: 'Donation Failed', description: error instanceof Error ? error.message : 'Could not connect to the payment gateway.' });
        setIsDonating(false);
    }
  };
  
  const topDonors = donors.slice(0, 3);
  const otherDonors = donors.slice(3);

  return (
    <div className="space-y-16 md:space-y-24">
      {/* Hero Section */}
      <section className="text-center space-y-4">
        <h1 className="text-4xl md:text-6xl font-headline font-bold primary-gradient bg-clip-text text-transparent">Fuel the Future of Students 🚀</h1>
        <p className="mt-4 max-w-2xl mx-auto text-lg text-muted-foreground">
          Every donation helps UniNest stay alive for your campus.
        </p>
        <Button size="lg" className="text-lg" onClick={() => document.getElementById('donate-section')?.scrollIntoView({ behavior: 'smooth' })}>
            Power Up Now ⚡
        </Button>
      </section>
      
      {/* Impact Section */}
      <section>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6 max-w-4xl mx-auto">
              {impactCards.map(card => (
                 <Link href={card.href} key={card.title}>
                    <Card className="text-center p-6 shadow-lg hover:shadow-2xl transition-shadow hover:-translate-y-2 h-full">
                        <div className="mx-auto bg-primary/10 text-primary size-16 rounded-full flex items-center justify-center mb-4">
                            <card.icon className="size-8" />
                        </div>
                        <h3 className="text-xl font-headline font-bold">{card.title}</h3>
                        <p className="text-muted-foreground">{card.description}</p>
                    </Card>
                 </Link>
              ))}
          </div>
      </section>

      {/* Donation & Leaderboard Section */}
      <div id="donate-section" className="grid lg:grid-cols-2 gap-12 items-start max-w-6xl mx-auto">
        {/* Donation Card */}
        <Card className="shadow-xl sticky top-24">
          <CardHeader>
            <CardTitle className="text-2xl font-headline">Help Us Reach Our Goal</CardTitle>
            <CardDescription>
              Our monthly server cost is ₹{goalAmount.toLocaleString()}. Every rupee helps keep the platform running and ad-free.
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-6">
            <div className="space-y-2">
              <Progress value={progressPercentage} className="h-3" />
              <div className="flex justify-between text-sm font-medium">
                <span className="text-primary">Raised: ₹{raisedAmount.toLocaleString()}</span>
                <span className="text-muted-foreground">Goal: ₹{goalAmount.toLocaleString()}</span>
              </div>
            </div>
             <div className="grid grid-cols-3 gap-3">
                {donationTiers.map(tier => (
                    <Button 
                        key={tier.amount} 
                        variant="outline"
                        className={cn(
                            "py-6 text-base font-bold transition-all border-2 flex flex-col h-auto",
                            donationAmount === tier.amount.toString() && "primary-gradient text-primary-foreground border-transparent ring-2 ring-primary"
                        )}
                        onClick={() => setDonationAmount(tier.amount.toString())}
                    >
                        <span className="text-lg">₹{tier.amount}</span>
                        <span className="text-xs font-normal">{tier.title}</span>
                    </Button>
                ))}
            </div>
            <div className="relative">
                <IndianRupee className="absolute left-3 top-1/2 -translate-y-1/2 size-5 text-muted-foreground" />
                <Input
                    type="number"
                    placeholder="Or enter a custom amount"
                    className="pl-10 text-center text-lg font-semibold h-14 rounded-xl"
                    value={donationAmount}
                    onChange={(e) => setDonationAmount(e.target.value)}
                />
            </div>
            <Button size="lg" className="w-full text-lg h-14" onClick={() => handleDonate(donationAmount)} disabled={!isLoaded || isDonating || !donationAmount}>
                {isLoaded ? <Sparkles className="mr-2 size-5" /> : <Loader2 className="mr-2 h-4 w-4 animate-spin" />}
                {isDonating ? 'Processing...' : `Donate ₹${donationAmount || 0}`}
            </Button>
          </CardContent>
        </Card>

        {/* Leaderboard Card */}
        <Card>
            <CardHeader>
                <CardTitle className="text-2xl font-headline flex items-center gap-2">
                    <Star className="text-amber-400" />
                    Hall of Heroes
                </CardTitle>
                <CardDescription>Meet the legends fueling UniNest this month.</CardDescription>
            </CardHeader>
            <CardContent className="space-y-6">
                {topDonors.length > 0 ? topDonors.map((donor, index) => (
                    <div key={donor.userId || index} className="flex items-center gap-4 p-3 rounded-lg bg-primary/10 border-2 border-primary/20">
                       <span className={cn("text-3xl font-bold w-8 text-center", medalColors[index])}>
                         {['🥇', '🥈', '🥉'][index]}
                       </span>
                        <Avatar className="size-12">
                            {donor.avatar && <AvatarImage src={donor.avatar} alt={donor.name || 'Anonymous'} data-ai-hint="person face" />}
                            <AvatarFallback className="text-xl">{donor.name?.charAt(0) || 'A'}</AvatarFallback>
                        </Avatar>
                        <div className="flex-1">
                            <p className="font-bold text-lg text-foreground">{donor.name || 'Anonymous'}</p>
                            <p className="text-sm text-primary font-semibold">₹{donor.amount.toLocaleString()}</p>
                        </div>
                    </div>
                )) : (
                     <div className="text-center text-muted-foreground py-10">
                        <p>Be the first to enter the Hall of Heroes!</p>
                    </div>
                )}
                
                {otherDonors.length > 0 && (
                  <ScrollArea className="h-64">
                    <div className="space-y-4 pr-4">
                        {otherDonors.map((donor, index) => (
                             <div key={donor.userId || index} className="flex items-center justify-between p-2 rounded-lg hover:bg-muted/50">
                                <div className="flex items-center gap-3">
                                    <Avatar className="size-9">
                                        {donor.avatar && <AvatarImage src={donor.avatar} alt={donor.name || 'Anonymous'} data-ai-hint="person face" />}
                                        <AvatarFallback>{donor.name?.charAt(0) || 'A'}</AvatarFallback>
                                    </Avatar>
                                    <p className="font-semibold">{donor.name || 'Anonymous'}</p>
                                </div>
                                <p className="font-medium text-muted-foreground">₹{donor.amount.toLocaleString()}</p>
                             </div>
                        ))}
                    </div>
                  </ScrollArea>
                )}
            </CardContent>
        </Card>
      </div>
      
       {/* Footer CTA */}
       <section className="text-center bg-card p-8 md:p-12 rounded-2xl shadow-xl max-w-4xl mx-auto">
          <h2 className="text-3xl font-bold font-headline primary-gradient bg-clip-text text-transparent">Your donation writes the next chapter 📖</h2>
          <p className="mt-2 max-w-2xl mx-auto text-muted-foreground">
            Join our community of supporters and make a direct impact on the student experience.
          </p>
          <div className="mt-6">
            <Button size="lg" className="text-lg" onClick={() => document.getElementById('donate-section')?.scrollIntoView({ behavior: 'smooth' })}>
                Donate Now & Join the Heroes ⚡
            </Button>
          </div>
        </section>
    </div>
  );
}

