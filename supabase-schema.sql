create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create table if not exists public.trades (
  user_id uuid not null references auth.users(id) on delete cascade,
  id text not null,
  trade_date date,
  data jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  primary key (user_id, id)
);

create index if not exists trades_user_date_idx on public.trades (user_id, trade_date);

drop trigger if exists set_trades_updated_at on public.trades;
create trigger set_trades_updated_at
before update on public.trades
for each row execute function public.set_updated_at();

alter table public.trades enable row level security;

drop policy if exists "Users can read own trades" on public.trades;
create policy "Users can read own trades"
on public.trades for select
using (auth.uid() = user_id);

drop policy if exists "Users can insert own trades" on public.trades;
create policy "Users can insert own trades"
on public.trades for insert
with check (auth.uid() = user_id);

drop policy if exists "Users can update own trades" on public.trades;
create policy "Users can update own trades"
on public.trades for update
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

drop policy if exists "Users can delete own trades" on public.trades;
create policy "Users can delete own trades"
on public.trades for delete
using (auth.uid() = user_id);

create table if not exists public.strategy_manuals (
  user_id uuid not null references auth.users(id) on delete cascade,
  id text not null,
  data jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  primary key (user_id, id)
);

drop trigger if exists set_strategy_manuals_updated_at on public.strategy_manuals;
create trigger set_strategy_manuals_updated_at
before update on public.strategy_manuals
for each row execute function public.set_updated_at();

alter table public.strategy_manuals enable row level security;

drop policy if exists "Users can read own strategy manuals" on public.strategy_manuals;
create policy "Users can read own strategy manuals"
on public.strategy_manuals for select
using (auth.uid() = user_id);

drop policy if exists "Users can insert own strategy manuals" on public.strategy_manuals;
create policy "Users can insert own strategy manuals"
on public.strategy_manuals for insert
with check (auth.uid() = user_id);

drop policy if exists "Users can update own strategy manuals" on public.strategy_manuals;
create policy "Users can update own strategy manuals"
on public.strategy_manuals for update
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

drop policy if exists "Users can delete own strategy manuals" on public.strategy_manuals;
create policy "Users can delete own strategy manuals"
on public.strategy_manuals for delete
using (auth.uid() = user_id);

create table if not exists public.user_settings (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

drop trigger if exists set_user_settings_updated_at on public.user_settings;
create trigger set_user_settings_updated_at
before update on public.user_settings
for each row execute function public.set_updated_at();

alter table public.user_settings enable row level security;

drop policy if exists "Users can read own settings" on public.user_settings;
create policy "Users can read own settings"
on public.user_settings for select
using (auth.uid() = user_id);

drop policy if exists "Users can insert own settings" on public.user_settings;
create policy "Users can insert own settings"
on public.user_settings for insert
with check (auth.uid() = user_id);

drop policy if exists "Users can update own settings" on public.user_settings;
create policy "Users can update own settings"
on public.user_settings for update
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

drop policy if exists "Users can delete own settings" on public.user_settings;
create policy "Users can delete own settings"
on public.user_settings for delete
using (auth.uid() = user_id);

create table if not exists public.kline_days (
  user_id uuid not null references auth.users(id) on delete cascade,
  day date not null,
  candles jsonb not null default '[]'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  primary key (user_id, day)
);

create index if not exists kline_days_user_day_idx on public.kline_days (user_id, day);

drop trigger if exists set_kline_days_updated_at on public.kline_days;
create trigger set_kline_days_updated_at
before update on public.kline_days
for each row execute function public.set_updated_at();

alter table public.kline_days enable row level security;

drop policy if exists "Users can read own kline days" on public.kline_days;
create policy "Users can read own kline days"
on public.kline_days for select
using (auth.uid() = user_id);

drop policy if exists "Users can insert own kline days" on public.kline_days;
create policy "Users can insert own kline days"
on public.kline_days for insert
with check (auth.uid() = user_id);

drop policy if exists "Users can update own kline days" on public.kline_days;
create policy "Users can update own kline days"
on public.kline_days for update
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

drop policy if exists "Users can delete own kline days" on public.kline_days;
create policy "Users can delete own kline days"
on public.kline_days for delete
using (auth.uid() = user_id);
