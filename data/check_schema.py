import json
from supabase import create_client
import os

SUPABASE_URL = os.environ.get("SUPABASE_URL")
SUPABASE_KEY = os.environ.get("SUPABASE_KEY")
supabase = create_client(SUPABASE_URL, SUPABASE_KEY)

# Try to fetch one row to see column names
try:
    response = supabase.table("products").select("*").limit(1).execute()
    print("Columns:", response.data[0].keys() if response.data else "No data")
except Exception as e:
    print("Error:", e)
