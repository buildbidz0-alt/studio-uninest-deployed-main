
'use client';

import { useEffect, useState } from 'react';
import { useSearchParams } from 'next/navigation';
import { Button } from '@/components/ui/button';
import { Card, CardContent } from '@/components/ui/card';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { Progress } from '@/components/ui/progress';
import { useAuth } from '@/hooks/use-auth';
import { Users, BookOpen, Library, Star, Share2, Rocket } from 'lucide-react';
import Link from 'next/link';
import dynamic from 'next/dynamic';
import { useWindowSize } from 'react-use';
import {
  Carousel,
  CarouselContent,
  CarouselItem,
  CarouselNext,
  CarouselPrevious,
} from "@/components/ui/carousel";

const Confetti = dynamic(() => import('react-confetti'), { ssr: false });

// --- Mock Data (replace with API calls) ---
const MOCK_STATS = {
  studentsHelped: 4521,
  notesShared: 12300,
  librariesDigitized: 2,
};

const MOCK_RECENT_DONORS = [
  { name: 'Rohan V.', avatar: 'https://picsum.photos/seed/donor1/40' },
  { name: 'Ananya S.', avatar: 'https://picsum.photos/seed/donor2/40' },
  { name: 'Kabir A.', avatar: 'https://picsum.photos/seed/donor3/40' },
  { name: 'Meera P.', avatar: 'https://picsum.photos/seed/donor4/40' },
  { name: 'Arjun K.', avatar: 'https://picsum.photos/seed/donor5/40' },
  { name: 'Sana R.', avatar: 'https://picsum.photos/seed/donor6/40' },
];

const MOCK_GOAL_PROGRESS = 74;

// --- Helper Functions & Components ---

const getBadgeForAmount = (amount: number) => {
  if (amount >= 250) {
    return { name: '🔥 UniNest Champion', icon: '🏆', color: 'text-amber-400' };
  }
  if (amount >= 100) {
    return { name: '✨ Campus Hero', icon: '🦸', color: 'text-sky-400' };
  }
  return { name: '📖 Knowledge Giver', icon: '📚', color: 'text-green-400' };
};

const AnimatedCounter = ({ to }: { to: number }) => {
  const [count, setCount] = useState(0);

  useEffect(() => {
    const duration = 1500; // ms
    const frameRate = 1000 / 60; // 60fps
    const totalFrames = Math.round(duration / frameRate);
    let frame = 0;

    const counter = setInterval(() => {
      frame++;
      const progress = frame / totalFrames;
      const currentCount = Math.round(to * progress);
      setCount(currentCount);

      if (frame === totalFrames) {
        clearInterval(counter);
      }
    }, frameRate);

    return () => clearInterval(counter);
  }, [to]);

  return <span className="font-bold">{count.toLocaleString()}</span>;
};

// --- Main Component ---

export default function ThankYouClient() {
  const searchParams = useSearchParams();
  const { user } = useAuth();
  const { width, height } = useWindowSize();
  const [showConfetti, setShowConfetti] = useState(false);

  useEffect(() => {
    // Trigger confetti on mount
    setShowConfetti(true);
    const timer = setTimeout(() => setShowConfetti(false), 8000); // Stop confetti after 8 seconds
    return () => clearTimeout(timer);
  }, []);

  const amount = Number(searchParams.get('amount') || '50');
  const isAnonymous = searchParams.get('anonymous') === 'true';
  const donorName = isAnonymous ? 'A kind soul' : user?.user_metadata?.full_name || 'Campus Hero';
  const badge = getBadgeForAmount(amount);

  const shareText = `I just fueled the future at UniNest by becoming a ${badge.name}! Join me in supporting our student community. 🚀`;

  return (
    <>
      {showConfetti && <Confetti width={width} height={height} recycle={false} numberOfPieces={400} />}
      <div className="max-w-2xl mx-auto space-y-12 py-8 text-center">
        {/* 1. Thank You Section */}
        <section className="space-y-3">
          <h1 className="text-4xl md:text-5xl font-headline font-bold primary-gradient bg-clip-text text-transparent">
            {isAnonymous ? 'A kind soul just made a difference 🙏' : `Thank you, ${donorName}! 🌟`}
          </h1>
          <p className="text-lg text-muted-foreground">
            You just unlocked a brighter campus for thousands of students.
          </p>
        </section>

        {/* 2. Contribution Badge */}
        <section>
          <Card className="bg-card/50 backdrop-blur-sm inline-block p-6 shadow-xl animate-in fade-in-50 zoom-in-90 duration-700">
            <div className="flex flex-col items-center gap-4">
              <span className="text-6xl animate-bounce [animation-delay:500ms]">{badge.icon}</span>
              <div>
                <p className="text-sm text-muted-foreground">YOU'VE UNLOCKED THE</p>
                <h2 className={`text-2xl font-bold font-headline ${badge.color}`}>{badge.name}</h2>
              </div>
              <p className="text-muted-foreground mt-2">You’re now a Campus Hero ✨ — wear your badge proudly!</p>
            </div>
          </Card>
        </section>

        {/* 3. Impact Highlights */}
        <section className="space-y-6">
           <h2 className="text-3xl font-bold font-headline">Your Real-World Impact</h2>
           <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
               <Card>
                  <CardContent className="p-4">
                      <Users className="size-8 mx-auto text-primary mb-2"/>
                      <p className="text-2xl"><AnimatedCounter to={MOCK_STATS.studentsHelped} /></p>
                      <p className="text-sm text-muted-foreground">Students Helped</p>
                  </CardContent>
               </Card>
               <Card>
                  <CardContent className="p-4">
                      <BookOpen className="size-8 mx-auto text-primary mb-2"/>
                      <p className="text-2xl"><AnimatedCounter to={MOCK_STATS.notesShared} /></p>
                      <p className="text-sm text-muted-foreground">Notes Shared</p>
                  </CardContent>
               </Card>
               <Card>
                  <CardContent className="p-4">
                      <Library className="size-8 mx-auto text-primary mb-2"/>
                       <p className="text-2xl"><AnimatedCounter to={MOCK_STATS.librariesDigitized} /></p>
                      <p className="text-sm text-muted-foreground">Libraries Digitized</p>
                  </CardContent>
               </Card>
           </div>
        </section>

        {/* 4. Community Impact Banner */}
        <section className="w-full">
            <h2 className="text-3xl font-bold font-headline mb-4">Join a Movement of Heroes</h2>
            <p className="text-muted-foreground mb-6">You're building the future of UniNest, one contribution at a time.</p>
             <Carousel opts={{ align: "start", loop: true }} className="w-full max-w-lg mx-auto">
                <CarouselContent>
                    {MOCK_RECENT_DONORS.map((donor, index) => (
                    <CarouselItem key={index} className="basis-1/3 sm:basis-1/4">
                        <div className="flex flex-col items-center gap-2">
                             <Avatar className="size-16 border-2 border-primary/50">
                                <AvatarImage src={donor.avatar} alt={donor.name} width={64} height={64} data-ai-hint="person face" />
                                <AvatarFallback>{donor.name.charAt(0)}</AvatarFallback>
                            </Avatar>
                            <p className="font-semibold text-sm">{donor.name}</p>
                        </div>
                    </CarouselItem>
                    ))}
                </CarouselContent>
                <CarouselPrevious className="hidden sm:flex" />
                <CarouselNext className="hidden sm:flex" />
            </Carousel>
        </section>

        {/* 5. Repeat Donation Teaser */}
        <section className="bg-card rounded-2xl p-8 shadow-xl">
            <h2 className="text-2xl font-bold font-headline mb-3">Keep the Momentum Going! ⚡</h2>
            <p className="text-muted-foreground">We’re at <span className="font-bold text-primary">{MOCK_GOAL_PROGRESS}%</span> of this month’s target to keep UniNest running ad-free!</p>
            <Progress value={MOCK_GOAL_PROGRESS} className="my-4 h-3" />
            <p className="text-sm text-muted-foreground mb-6">Help us reach 100% to unlock free premium features for all students. 🎉</p>
            <div className="flex flex-col sm:flex-row gap-3 justify-center">
                 <Button size="lg" asChild>
                    <Link href="/donate">
                        <Rocket className="mr-2"/>
                        Donate Again
                    </Link>
                </Button>
                <Button size="lg" variant="outline" asChild>
                    <a href={`https://twitter.com/intent/tweet?text=${encodeURIComponent(shareText)}&url=${'https://uninest.app'}`} target="_blank" rel="noopener noreferrer">
                        <Share2 className="mr-2"/>
                        Share Your Impact
                    </a>
                </Button>
            </div>
        </section>
      </div>
    </>
  );
}
