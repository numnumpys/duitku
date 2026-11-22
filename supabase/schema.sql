-- Skema Duitku untuk Supabase (dipakai mulai Hari 2).
-- Jalankan di Supabase Dashboard > SQL Editor.

create table if not exists public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  name text,
  created_at timestamptz not null default now()
);

create table if not exists public.categories (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users (id) on delete cascade,
  name text not null,
  type text not null check (type in ('income', 'expense')),
  icon_key text not null default 'category',
  color_value bigint not null,
  created_at timestamptz not null default now()
);

create table if not exists public.transactions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users (id) on delete cascade,
  category_id uuid not null references public.categories (id) on delete restrict,
  amount bigint not null check (amount > 0),
  note text,
  date timestamptz not null,
  type text not null check (type in ('income', 'expense')),
  created_at timestamptz not null default now()
);

create table if not exists public.budgets (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users (id) on delete cascade,
  category_id uuid not null references public.categories (id) on delete cascade,
  month date not null,
  limit_amount bigint not null check (limit_amount >= 0),
  unique (user_id, category_id, month)
);

create index if not exists transactions_user_date_idx
  on public.transactions (user_id, date desc);

-- Row Level Security: tiap pengguna hanya bisa mengakses datanya sendiri.
alter table public.profiles enable row level security;
alter table public.categories enable row level security;
alter table public.transactions enable row level security;
alter table public.budgets enable row level security;

create policy "profiles: milik sendiri" on public.profiles
  for all using (id = auth.uid()) with check (id = auth.uid());

create policy "categories: milik sendiri" on public.categories
  for all using (user_id = auth.uid()) with check (user_id = auth.uid());

create policy "transactions: milik sendiri" on public.transactions
  for all using (user_id = auth.uid()) with check (user_id = auth.uid());

create policy "budgets: milik sendiri" on public.budgets
  for all using (user_id = auth.uid()) with check (user_id = auth.uid());
