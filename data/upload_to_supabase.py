import json
from supabase import create_client
import os
import uuid
import hashlib

SUPABASE_URL = os.environ.get("SUPABASE_URL")
SUPABASE_KEY = os.environ.get("SUPABASE_KEY")
supabase = create_client(SUPABASE_URL, SUPABASE_KEY)

# Load data
with open('C:/Users/mjnol/.openclaw/workspace/projects/ecommerce-components/data/all_products.json', 'r', encoding='utf-8') as f:
    products = json.load(f)

# Upload products
for i, product in enumerate(products):
    try:
        # Map scraped data to schema
        price_cents = int(float(product["price"].replace(" €", "").replace(",", ".")) * 100)
        
        data = {
            "platform": "internal",
            "external_sku": hashlib.md5(product["url"].encode()).hexdigest(),
            "internal_sku": f"IC_{i:04d}",
            "name": product["name"][:300], # Max 300
            "description": product.get("name", ""),
            "price_cents": price_cents,
            "currency": "EUR", # The prices were in €
            "platform_metadata": {
                "url": product["url"],
                "image_url": product["imageUrl"],
                "source": product["source"]
            }
        }
        
        supabase.table("products").insert(data).execute()
        print(f"Uploaded: {data['name']}")
    except Exception as e:
        print(f"Error uploading {product.get('name')}: {e}")

print("Upload complete!")
