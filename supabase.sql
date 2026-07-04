-- 1. Drop the table if it already exists to ensure a clean setup
DROP TABLE IF EXISTS public.habits;

-- 2. Create the habits table matching the precise camelCase fields from index.html
CREATE TABLE public.habits (
    -- Alphanumeric unique string ID generated on the client side
    id text PRIMARY KEY, 
    
    -- Core habit specifications
    name text NOT NULL,
    emoji text NOT NULL DEFAULT '🌱',
    color text NOT NULL DEFAULT '#5B5BD6',
    type text NOT NULL DEFAULT 'daily', -- Options: 'daily', 'multi', 'weekly', 'break'
    goal integer NOT NULL DEFAULT 60,
    
    -- Structure configurations matching frontend inputs
    reminder jsonb NOT NULL DEFAULT '{"enabled": false, "time": "09:00"}'::jsonb,
    "dailyTarget" integer DEFAULT 1,
    "weeklyGoal" integer DEFAULT 3,
    
    -- Map trackers linking individual date strings to progress values
    log jsonb NOT NULL DEFAULT '{}'::jsonb,
    notes jsonb NOT NULL DEFAULT '{}'::jsonb,
    
    -- Status values
    "freezeBank" integer NOT NULL DEFAULT 2,
    "createdAt" timestamp with time zone NOT NULL DEFAULT timezone('utc'::text, now())
);

-- 3. Optimize processing performance for the client-side chronological ordering
CREATE INDEX IF NOT EXISTS habits_created_at_idx ON public.habits ("createdAt" ASC);

-- 4. Enable Row Level Security (RLS)
ALTER TABLE public.habits ENABLE ROW LEVEL SECURITY;

-- 5. Option A Policy: Open global anonymous read/write access via the Anon Key
CREATE POLICY "Allow public anonymous access to all habits" 
ON public.habits
FOR ALL
USING (true)
WITH CHECK (true);
