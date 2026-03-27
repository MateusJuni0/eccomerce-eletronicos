const fs = require('fs');

const categories = ['Placas Gráficas', 'Processadores', 'Motherboards', 'Memória RAM', 'Armazenamento', 'Fontes de Alimentação', 'Caixas'];
const stores = ['PCDiga', 'Globaldata', 'PcComponentes', 'Chiptec', 'InfoComputer'];
const brands = {
  'Placas Gráficas': ['ASUS ROG', 'MSI Gaming', 'Gigabyte AORUS', 'ZOTAC', 'Sapphire'],
  'Processadores': ['Intel Core', 'AMD Ryzen'],
  'Motherboards': ['ASUS', 'MSI', 'Gigabyte', 'ASRock'],
  'Memória RAM': ['Corsair', 'G.Skill', 'Kingston FURY', 'Crucial'],
  'Armazenamento': ['Samsung', 'WD_BLACK', 'Crucial', 'Seagate'],
  'Fontes de Alimentação': ['Corsair', 'Seasonic', 'EVGA', 'be quiet!'],
  'Caixas': ['Lian Li', 'Corsair', 'Fractal Design', 'NZXT']
};

function slugify(text) {
  return text.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/(^-|-$)/g, '');
}

let sql = `-- Script gerado\n\n`;

for (let cat of categories) {
  sql += `INSERT INTO ecommerce.categories (name, slug) VALUES ('${cat}', '${slugify(cat)}') ON CONFLICT (slug) DO NOTHING;\n`;
}

sql += `\n`;

for (let i = 1; i <= 200; i++) {
  const cat = categories[Math.floor(Math.random() * categories.length)];
  const store = stores[Math.floor(Math.random() * stores.length)];
  const brand = brands[cat][Math.floor(Math.random() * brands[cat].length)];
  
  let model = `Model ${Math.floor(Math.random() * 9000) + 1000}`;
  let title = `${brand} ${cat.split(' ')[0]} Premium ${model}`;
  let slug = slugify(title) + `-${i}`;
  let price = (Math.random() * 800 + 50).toFixed(2);
  let stock = Math.floor(Math.random() * 50);
  
  sql += `INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT '${title}', '${slug}', ${price}, c.id, '${store}', ARRAY['https://picsum.photos/seed/${slug}/600/400'], '{"brand": "${brand}"}'::jsonb, ${stock}
FROM ecommerce.categories c WHERE c.slug = '${slugify(cat)}'
ON CONFLICT (slug) DO NOTHING;\n`;
}

fs.writeFileSync('C:/Users/mjnol/.openclaw/workspace/projects/ecommerce-components/supabase/ecommerce_seed.sql', sql);
