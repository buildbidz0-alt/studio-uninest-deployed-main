
'use server';

import { createClient } from '@/lib/supabase/server';
import { z } from 'zod';
import { revalidatePath } from 'next/cache';

const studentMonetizationSchema = z.object({
  charge_for_posts: z.boolean(),
  post_price: z.number().min(0),
});

const vendorMonetizationSchema = z.object({
  charge_for_platform_access: z.boolean(),
  price_per_service_per_month: z.number().min(0),
});

const settingsSchema = z.object({
  student: studentMonetizationSchema,
  vendor: vendorMonetizationSchema,
  start_date: z.string().datetime({ offset: true }).nullable(),
});

export async function updateSettings(settings: unknown) {
  try {
    const supabase = createClient();

    // 1. Check for authenticated user
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) {
      throw new Error('Unauthorized: No user logged in.');
    }

    // 2. Check if the user is an admin
    const isAdmin = user.user_metadata?.role === 'admin';
    if (!isAdmin) {
      throw new Error('Forbidden: Admins only.');
    }

    // 3. Validate request body
    const parsedBody = settingsSchema.safeParse(settings);
    if (!parsedBody.success) {
      throw new Error(`Invalid request body: ${parsedBody.error.message}`);
    }

    // 4. Upsert the settings in the database
    const { error: dbError } = await supabase
      .from('platform_settings')
      .upsert({
        key: 'monetization',
        value: parsedBody.data,
      }, {
        onConflict: 'key',
      });

    if (dbError) {
      console.error('Error upserting settings:', dbError);
      throw new Error('Failed to save settings in database.');
    }

    // 5. Log the action to the audit log
    const { error: logError } = await supabase.from('audit_log').insert({
      admin_id: user.id,
      action: 'settings_update',
      details: `Updated monetization settings.`,
    });

    if (logError) {
      console.error("Failed to write to audit log:", logError);
      // Do not fail the request, but log the error
    }
    
    revalidatePath('/admin/settings');
    return { error: null };

  } catch (e: any) {
    return { error: e.message };
  }
}

    