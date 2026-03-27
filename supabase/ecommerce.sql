CREATE SCHEMA IF NOT EXISTS ecommerce;

CREATE TABLE IF NOT EXISTS ecommerce.categories (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    slug TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS ecommerce.products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title TEXT NOT NULL,
    slug TEXT NOT NULL UNIQUE,
    price DECIMAL(10,2) NOT NULL,
    category UUID REFERENCES ecommerce.categories(id),
    store_source TEXT NOT NULL,
    images TEXT[] DEFAULT '{}',
    specs JSONB DEFAULT '{}'::jsonb,
    stock INT DEFAULT 0
);

CREATE TABLE IF NOT EXISTS ecommerce.profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id),
    name TEXT,
    email TEXT
);

CREATE TABLE IF NOT EXISTS ecommerce.orders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES ecommerce.profiles(id),
    total DECIMAL(10,2) NOT NULL,
    status TEXT DEFAULT 'pending',
    payment_method TEXT DEFAULT 'mbway'
);

CREATE TABLE IF NOT EXISTS ecommerce.order_items (
    order_id UUID REFERENCES ecommerce.orders(id),
    product_id UUID REFERENCES ecommerce.products(id),
    quantity INT NOT NULL,
    price_at_time DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (order_id, product_id)
);

-- RLS
ALTER TABLE ecommerce.products ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public products are viewable by everyone." ON ecommerce.products FOR SELECT USING (true);

ALTER TABLE ecommerce.categories ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public categories are viewable by everyone." ON ecommerce.categories FOR SELECT USING (true);

-- API grant
GRANT USAGE ON SCHEMA ecommerce TO anon, authenticated;
GRANT ALL ON ALL TABLES IN SCHEMA ecommerce TO anon, authenticated;

-- Seed Data
INSERT INTO ecommerce.categories (name, slug) VALUES 
('Placas Gráficas', 'placas-graficas'),
('Processadores', 'processadores'),
('Motherboards', 'motherboards'),
('Memória RAM', 'memoria-ram')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'RTX 4090 Gaming X Trio', 'rtx-4090-gaming-x-trio', 1899.90, c.id, 'PCDiga', ARRAY['https://example.com/rtx4090.jpg'], '{"vram": "24GB GDDR6X"}', 5
FROM ecommerce.categories c WHERE c.slug = 'placas-graficas'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'AMD Ryzen 9 7950X3D', 'amd-ryzen-9-7950x3d', 649.90, c.id, 'Globaldata', ARRAY['https://example.com/ryzen9.jpg'], '{"cores": 16, "threads": 32}', 15
FROM ecommerce.categories c WHERE c.slug = 'processadores'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'ASUS ROG Strix Z790-E', 'asus-rog-strix-z790-e', 549.90, c.id, 'Chiptec', ARRAY['https://example.com/z790.jpg'], '{"socket": "LGA 1700"}', 10
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Corsair Vengeance RGB 32GB DDR5 6000MHz', 'corsair-vengeance-rgb-32gb', 149.90, c.id, 'PcComponentes', ARRAY['https://example.com/ram.jpg'], '{"speed": "6000MHz", "capacity": "32GB"}', 50
FROM ecommerce.categories c WHERE c.slug = 'memoria-ram'
ON CONFLICT (slug) DO NOTHING;