DROP TABLE IF EXISTS public.habits CASCADE;

CREATE TABLE public.habits (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    emoji TEXT,
    color TEXT,
    type TEXT NOT NULL,
    goal INTEGER DEFAULT 60,
    "dailyTarget" INTEGER,
    "weeklyGoal" INTEGER,
    "timeOfDay" TEXT DEFAULT 'anytime',
    reminders JSONB DEFAULT '[]'::jsonb,
    notes JSONB DEFAULT '{}'::jsonb,
    "sortOrder" INTEGER DEFAULT 0,
    "isArchived" BOOLEAN DEFAULT false,
    log JSONB DEFAULT '{}'::jsonb,
    "createdAt" TIMESTAMPTZ DEFAULT NOW(),
    "updatedAt" TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.habits ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public anonymous access" 
ON public.habits 
FOR ALL 
TO anon 
USING (true) 
WITH CHECK (true);

CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW."updatedAt" = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_habits_updated_at
    BEFORE UPDATE ON public.habits
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();
