
import type { User } from "@supabase/supabase-js";

export type Profile = {
  id: string;
  full_name: string | null;
  avatar_url: string | null;
  handle: string | null;
  bio?: string | null;
  followers?: { count: number }[];
  following?: { count: number }[];
};

export type Room = {
  id: string;
  name: string | null;
  avatar: string | null;
  last_message: string | null;
  last_message_timestamp: string | null;
  unread_count: number | null;
  room_created_at: string;
};

export type Message = {
  id: string;
  content: string;
  created_at: string;
  room_id: string;
  user_id: string;
  profile: Profile | null;
};

export type Product = {
  id: number;
  created_at: string;
  name: string;
  price: number;
  image_url: string | null;
  category: string;
  seller_id: string;
  description: string;
  location: string | null;
  total_seats: number | null;
  parent_product_id: number | null;
  status: string;
  seller: {
    id: string;
    full_name: string;
    avatar_url: string;
    handle: string;
    user_metadata: any;
  };
  // This field is for the raw query result
  profiles?: {
    full_name: string;
  };
};

export type Note = {
  id: number;
  created_at: string;
  user_id: string;
  title: string;
  description: string | null;
  file_url: string;
  file_type: string;
  tags: string[] | null;
  profiles: {
    full_name: string;
    avatar_url: string;
  } | null;
}

export type Order = {
  id: number;
  created_at: string;
  buyer_id: string;
  vendor_id: string;
  total_amount: number;
  razorpay_payment_id: string;
  status: 'pending_approval' | 'approved' | 'rejected' | 'completed' | null;
  booking_date?: string | null;
  booking_slot?: string | null;
  order_items: OrderItem[];
  buyer: Profile;
}

export type OrderItem = {
    id: number;
    order_id: number;
    product_id: number;
    quantity: number;
    price: number;
    products: {
        name: string;
        image_url: string | null;
    },
    seat_number?: number;
    library_id?: number;
}

export type Notification = {
    id: number;
    created_at: string;
    user_id: string;
    sender_id: string;
    type: 'new_follower' | 'new_post';
    post_id: number | null;
    is_read: boolean;
    sender: {
        full_name: string;
        avatar_url: string;
    } | null;
}

export type PostWithAuthor = {
  id: number;
  content: string;
  created_at: string;
  user_id: string;
  likes: { count: number }[];
  comments: any[]; 
  profiles: {
    full_name: string;
    avatar_url: string;
    handle: string;
  } | null;
  isLiked: boolean;
  isFollowed: boolean;
};

type StudentMonetizationSetting = {
    charge_for_posts: boolean;
    post_price: number;
}

type VendorMonetizationSetting = {
    charge_for_platform_access: boolean;
    price_per_service_per_month: number;
}

export type MonetizationSettings = {
    student: StudentMonetizationSetting;
    vendor: VendorMonetizationSetting;
    start_date: string | null;
};

export type SupportTicket = {
  id: number;
  created_at: string;
  user_id: string;
  category: string;
  subject: string;
  description: string;
  status: 'Open' | 'In Progress' | 'Closed' | 'Archived';
  priority: 'Low' | 'Medium' | 'High';
  screenshot_url?: string | null;
  profile?: {
      id: string;
      full_name: string;
      avatar_url: string | null;
  } | null;
};
