

import type { Metadata } from 'next';
import DonateContent from '@/components/donate/donate-content';
import { createClient } from '@/lib/supabase/server';

export const revalidate = 0;

export const metadata: Metadata = {
  title: 'Support UniNest – Fuel the Future of Students',
  description: 'Your donation helps UniNest stay alive for your campus. Join the Hall of Heroes and contribute to keep the platform running for students.',
};

type AggregatedDonor = {
    name: string | null;
    avatar: string | null;
    amount: number;
    userId: string;
}

export default async function DonatePage() {
    const supabase = createClient();
    
    // Fetch initial data for SSR
    const { data: donations, error: donorsError } = await supabase
        .from('donations')
        .select(`
            user_id,
            amount,
            profiles (
                full_name,
                avatar_url
            )
        `)
        .order('amount', { ascending: false });

    const { data: goalData, error: goalError } = await supabase
        .from('app_config')
        .select('value')
        .eq('key', 'donation_goal')
        .single();
    
    const { data: raisedData, error: raisedError } = await supabase
        .from('donations')
        .select('amount');

    if (donorsError) console.error('Error fetching donors:', donorsError.message);
    if (raisedError) console.error('Error fetching raised amount:', raisedError.message);

    const aggregatedDonors: AggregatedDonor[] = (donations || []).reduce((acc: AggregatedDonor[], current) => {
        if (!current.profiles) return acc;
        const existing = acc.find(d => d.userId === current.user_id);
        if (existing) {
            existing.amount += current.amount;
        } else {
            acc.push({
                name: current.profiles.full_name,
                userId: current.user_id,
                avatar: current.profiles.avatar_url,
                amount: current.amount
            });
        }
        return acc;
    }, []).sort((a,b) => b.amount - a.amount);


    const goalAmount = goalData ? Number(goalData.value) : 50000;
    const initialRaisedAmount = (raisedData || []).reduce((sum, d) => sum + d.amount, 0);

    return <DonateContent 
        initialDonors={aggregatedDonors as any[] || []}
        initialGoal={goalAmount}
        initialRaised={initialRaisedAmount}
    />
}
