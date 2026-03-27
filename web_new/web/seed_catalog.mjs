import { createClient } from '@supabase/supabase-js';

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || 'http://72.60.88.137:8000';
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyAgCiAgICAicm9sZSI6ICJhbm9uIiwKICAgICJpc3MiOiAic3VwYWJhc2UtZGVtbyIsCiAgICAiaWF0IjogMTY0MTc2OTIwMCwKICAgICJleHAiOiAxNzk5NTM1NjAwCn0.dc_X5iR_VP_qT0zsiyj_I_OZ2T9FtRU2BBNWN8Bu4GE';
const supabase = createClient(supabaseUrl, supabaseKey);

const categories = [
  { prefix: 'Placa Gráfica', brands: ['ASUS ROG Strix', 'MSI Gaming X Trio', 'Gigabyte AORUS', 'ZOTAC Trinity', 'Sapphire Nitro+'], models: ['RTX 4090 24GB', 'RTX 4080 Super 16GB', 'RTX 4070 Ti 12GB', 'RTX 4060 8GB', 'RX 7900 XTX 24GB', 'RX 7800 XT 16GB'], images: ['https://images.unsplash.com/photo-1591488320449-011701bb6704?q=80&w=800&auto=format&fit=crop'], basePrice: 300, maxPrice: 2000 },
  { prefix: 'Processador', brands: ['Intel Core', 'AMD Ryzen'], models: ['i9-14900K', 'i7-14700K', 'i5-13600K', '9 7950X3D', '7 7800X3D', '5 7600X'], images: ['https://images.unsplash.com/photo-1591799264318-7e6ef8ddb7ea?q=80&w=800&auto=format&fit=crop'], basePrice: 200, maxPrice: 700 },
  { prefix: 'Motherboard', brands: ['ASUS ROG', 'MSI MAG', 'Gigabyte AORUS', 'ASRock Taichi'], models: ['Z790-E Gaming WiFi', 'B760 Tomahawk', 'X670E Hero', 'B650E-F'], images: ['https://images.unsplash.com/photo-1518770660439-4636190af475?q=80&w=800&auto=format&fit=crop'], basePrice: 150, maxPrice: 600 },
  { prefix: 'Memória RAM', brands: ['Corsair Dominator', 'G.Skill Trident Z5', 'Kingston FURY', 'TeamGroup Delta'], models: ['32GB (2x16GB) DDR5 6000MHz CL30', '64GB (2x32GB) DDR5 6400MHz CL32', '16GB (2x8GB) DDR4 3600MHz CL16'], images: ['https://images.unsplash.com/photo-1562976540-1502c2145186?q=80&w=800&auto=format&fit=crop'], basePrice: 80, maxPrice: 300 },
  { prefix: 'SSD', brands: ['Samsung 990 PRO', 'WD Black SN850X', 'Crucial T700', 'Kingston KC3000'], models: ['1TB M.2 NVMe', '2TB M.2 NVMe PCIe 4.0', '4TB M.2 NVMe PCIe 5.0'], images: ['https://images.unsplash.com/photo-1628557044797-f21a177c37ec?q=80&w=800&auto=format&fit=crop'], basePrice: 90, maxPrice: 400 },
  { prefix: 'Fonte de Alimentação', brands: ['Corsair', 'Seasonic', 'EVGA', 'be quiet!'], models: ['RM850x 850W 80 Plus Gold', 'Prime TX-1000 1000W Titanium', 'SuperNOVA 1200W Platinum', 'Dark Power 13 850W'], images: ['https://images.unsplash.com/photo-1587202372634-32705e3bf49c?q=80&w=800&auto=format&fit=crop'], basePrice: 100, maxPrice: 350 },
  { prefix: 'Caixa', brands: ['Lian Li', 'NZXT', 'Fractal Design', 'Corsair', 'Phanteks'], models: ['O11 Dynamic EVO', 'H9 Flow', 'North', '4000D Airflow', 'NV7'], images: ['https://images.unsplash.com/photo-1587202372775-e229f172b9d7?q=80&w=800&auto=format&fit=crop'], basePrice: 90, maxPrice: 250 },
];

const generatedProducts = [];
let skuCounter = 1;

for (let i = 0; i < 200; i++) {
  const cat = categories[Math.floor(Math.random() * categories.length)];
  const brand = cat.brands[Math.floor(Math.random() * cat.brands.length)];
  const model = cat.models[Math.floor(Math.random() * cat.models.length)];
  const name = `${cat.prefix} ${brand} ${model}`;
  
  const priceRange = cat.maxPrice - cat.basePrice;
  const randomPrice = cat.basePrice + (Math.random() * priceRange);
  const priceCents = Math.floor(randomPrice * 100);
  
  generatedProducts.push({
    name,
    description: `Componente premium para entusiastas. O ${name} oferece performance excecional, design robusto e fiabilidade máxima para o teu setup.`,
    price_cents: priceCents,
    currency: 'EUR',
    platform: 'internal',
    external_sku: `MOCK_EXT_${skuCounter}`,
    internal_sku: `CM_ELITE_${skuCounter.toString().padStart(4, '0')}`,
    platform_metadata: {
      image_url: cat.images[0],
      source: 'CMTecnologia Elite Catalog',
      brand,
      model
    }
  });
  skuCounter++;
}

async function run() {
  console.log('Clearing old products...');
  await supabase.from('products').delete().neq('id', '00000000-0000-0000-0000-000000000000'); // Delete all

  console.log(`Inserting ${generatedProducts.length} premium products...`);
  
  // Insert in batches of 50
  for (let i = 0; i < generatedProducts.length; i += 50) {
    const batch = generatedProducts.slice(i, i + 50);
    const { error } = await supabase.from('products').insert(batch);
    if (error) {
      console.error('Error inserting batch:', error);
    } else {
      console.log(`Inserted batch ${i/50 + 1}`);
    }
  }
  
  console.log('✅ Done! 200 Products injected.');
}

run();