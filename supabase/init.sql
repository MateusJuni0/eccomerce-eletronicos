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
-- Script gerado

INSERT INTO ecommerce.categories (name, slug) VALUES ('Placas Gráficas', 'placas-gr-ficas') ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.categories (name, slug) VALUES ('Processadores', 'processadores') ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.categories (name, slug) VALUES ('Motherboards', 'motherboards') ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.categories (name, slug) VALUES ('Memória RAM', 'mem-ria-ram') ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.categories (name, slug) VALUES ('Armazenamento', 'armazenamento') ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.categories (name, slug) VALUES ('Fontes de Alimentação', 'fontes-de-alimenta-o') ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.categories (name, slug) VALUES ('Caixas', 'caixas') ON CONFLICT (slug) DO NOTHING;

INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Lian Li Caixas Premium Model 9217', 'lian-li-caixas-premium-model-9217-1', 379.39, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/lian-li-caixas-premium-model-9217-1/600/400'], '{"brand": "Lian Li"}'::jsonb, 44
FROM ecommerce.categories c WHERE c.slug = 'caixas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'be quiet! Fontes Premium Model 7252', 'be-quiet-fontes-premium-model-7252-2', 383.54, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/be-quiet-fontes-premium-model-7252-2/600/400'], '{"brand": "be quiet!"}'::jsonb, 45
FROM ecommerce.categories c WHERE c.slug = 'fontes-de-alimenta-o'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Lian Li Caixas Premium Model 2183', 'lian-li-caixas-premium-model-2183-3', 542.44, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/lian-li-caixas-premium-model-2183-3/600/400'], '{"brand": "Lian Li"}'::jsonb, 38
FROM ecommerce.categories c WHERE c.slug = 'caixas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'NZXT Caixas Premium Model 3335', 'nzxt-caixas-premium-model-3335-4', 317.50, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/nzxt-caixas-premium-model-3335-4/600/400'], '{"brand": "NZXT"}'::jsonb, 14
FROM ecommerce.categories c WHERE c.slug = 'caixas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Sapphire Placas Premium Model 3614', 'sapphire-placas-premium-model-3614-5', 385.00, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/sapphire-placas-premium-model-3614-5/600/400'], '{"brand": "Sapphire"}'::jsonb, 27
FROM ecommerce.categories c WHERE c.slug = 'placas-gr-ficas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'NZXT Caixas Premium Model 4725', 'nzxt-caixas-premium-model-4725-6', 348.83, c.id, 'Chiptec', ARRAY['https://picsum.photos/seed/nzxt-caixas-premium-model-4725-6/600/400'], '{"brand": "NZXT"}'::jsonb, 44
FROM ecommerce.categories c WHERE c.slug = 'caixas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'ZOTAC Placas Premium Model 2839', 'zotac-placas-premium-model-2839-7', 297.53, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/zotac-placas-premium-model-2839-7/600/400'], '{"brand": "ZOTAC"}'::jsonb, 46
FROM ecommerce.categories c WHERE c.slug = 'placas-gr-ficas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'ZOTAC Placas Premium Model 8031', 'zotac-placas-premium-model-8031-8', 685.07, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/zotac-placas-premium-model-8031-8/600/400'], '{"brand": "ZOTAC"}'::jsonb, 6
FROM ecommerce.categories c WHERE c.slug = 'placas-gr-ficas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Intel Core Processadores Premium Model 8982', 'intel-core-processadores-premium-model-8982-9', 669.17, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/intel-core-processadores-premium-model-8982-9/600/400'], '{"brand": "Intel Core"}'::jsonb, 37
FROM ecommerce.categories c WHERE c.slug = 'processadores'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Seasonic Fontes Premium Model 1351', 'seasonic-fontes-premium-model-1351-10', 848.18, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/seasonic-fontes-premium-model-1351-10/600/400'], '{"brand": "Seasonic"}'::jsonb, 44
FROM ecommerce.categories c WHERE c.slug = 'fontes-de-alimenta-o'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Seagate Armazenamento Premium Model 7789', 'seagate-armazenamento-premium-model-7789-11', 349.31, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/seagate-armazenamento-premium-model-7789-11/600/400'], '{"brand": "Seagate"}'::jsonb, 9
FROM ecommerce.categories c WHERE c.slug = 'armazenamento'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Seagate Armazenamento Premium Model 4029', 'seagate-armazenamento-premium-model-4029-12', 609.37, c.id, 'InfoComputer', ARRAY['https://picsum.photos/seed/seagate-armazenamento-premium-model-4029-12/600/400'], '{"brand": "Seagate"}'::jsonb, 9
FROM ecommerce.categories c WHERE c.slug = 'armazenamento'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Seagate Armazenamento Premium Model 5439', 'seagate-armazenamento-premium-model-5439-13', 370.21, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/seagate-armazenamento-premium-model-5439-13/600/400'], '{"brand": "Seagate"}'::jsonb, 47
FROM ecommerce.categories c WHERE c.slug = 'armazenamento'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Seagate Armazenamento Premium Model 4904', 'seagate-armazenamento-premium-model-4904-14', 139.62, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/seagate-armazenamento-premium-model-4904-14/600/400'], '{"brand": "Seagate"}'::jsonb, 33
FROM ecommerce.categories c WHERE c.slug = 'armazenamento'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Corsair Caixas Premium Model 1713', 'corsair-caixas-premium-model-1713-15', 325.46, c.id, 'Chiptec', ARRAY['https://picsum.photos/seed/corsair-caixas-premium-model-1713-15/600/400'], '{"brand": "Corsair"}'::jsonb, 46
FROM ecommerce.categories c WHERE c.slug = 'caixas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Crucial Memória Premium Model 6070', 'crucial-mem-ria-premium-model-6070-16', 506.96, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/crucial-mem-ria-premium-model-6070-16/600/400'], '{"brand": "Crucial"}'::jsonb, 34
FROM ecommerce.categories c WHERE c.slug = 'mem-ria-ram'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'G.Skill Memória Premium Model 4179', 'g-skill-mem-ria-premium-model-4179-17', 788.24, c.id, 'Chiptec', ARRAY['https://picsum.photos/seed/g-skill-mem-ria-premium-model-4179-17/600/400'], '{"brand": "G.Skill"}'::jsonb, 3
FROM ecommerce.categories c WHERE c.slug = 'mem-ria-ram'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'NZXT Caixas Premium Model 9256', 'nzxt-caixas-premium-model-9256-18', 580.47, c.id, 'Chiptec', ARRAY['https://picsum.photos/seed/nzxt-caixas-premium-model-9256-18/600/400'], '{"brand": "NZXT"}'::jsonb, 49
FROM ecommerce.categories c WHERE c.slug = 'caixas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Crucial Memória Premium Model 3145', 'crucial-mem-ria-premium-model-3145-19', 645.39, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/crucial-mem-ria-premium-model-3145-19/600/400'], '{"brand": "Crucial"}'::jsonb, 40
FROM ecommerce.categories c WHERE c.slug = 'mem-ria-ram'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Corsair Memória Premium Model 1159', 'corsair-mem-ria-premium-model-1159-20', 597.16, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/corsair-mem-ria-premium-model-1159-20/600/400'], '{"brand": "Corsair"}'::jsonb, 3
FROM ecommerce.categories c WHERE c.slug = 'mem-ria-ram'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'ZOTAC Placas Premium Model 7467', 'zotac-placas-premium-model-7467-21', 695.80, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/zotac-placas-premium-model-7467-21/600/400'], '{"brand": "ZOTAC"}'::jsonb, 6
FROM ecommerce.categories c WHERE c.slug = 'placas-gr-ficas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'NZXT Caixas Premium Model 4225', 'nzxt-caixas-premium-model-4225-22', 334.31, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/nzxt-caixas-premium-model-4225-22/600/400'], '{"brand": "NZXT"}'::jsonb, 18
FROM ecommerce.categories c WHERE c.slug = 'caixas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'MSI Gaming Placas Premium Model 6260', 'msi-gaming-placas-premium-model-6260-23', 501.82, c.id, 'InfoComputer', ARRAY['https://picsum.photos/seed/msi-gaming-placas-premium-model-6260-23/600/400'], '{"brand": "MSI Gaming"}'::jsonb, 39
FROM ecommerce.categories c WHERE c.slug = 'placas-gr-ficas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Corsair Fontes Premium Model 4891', 'corsair-fontes-premium-model-4891-24', 196.66, c.id, 'Chiptec', ARRAY['https://picsum.photos/seed/corsair-fontes-premium-model-4891-24/600/400'], '{"brand": "Corsair"}'::jsonb, 49
FROM ecommerce.categories c WHERE c.slug = 'fontes-de-alimenta-o'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Corsair Memória Premium Model 7964', 'corsair-mem-ria-premium-model-7964-25', 50.94, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/corsair-mem-ria-premium-model-7964-25/600/400'], '{"brand": "Corsair"}'::jsonb, 24
FROM ecommerce.categories c WHERE c.slug = 'mem-ria-ram'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Crucial Armazenamento Premium Model 7361', 'crucial-armazenamento-premium-model-7361-26', 563.21, c.id, 'InfoComputer', ARRAY['https://picsum.photos/seed/crucial-armazenamento-premium-model-7361-26/600/400'], '{"brand": "Crucial"}'::jsonb, 38
FROM ecommerce.categories c WHERE c.slug = 'armazenamento'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Kingston FURY Memória Premium Model 3655', 'kingston-fury-mem-ria-premium-model-3655-27', 464.54, c.id, 'InfoComputer', ARRAY['https://picsum.photos/seed/kingston-fury-mem-ria-premium-model-3655-27/600/400'], '{"brand": "Kingston FURY"}'::jsonb, 30
FROM ecommerce.categories c WHERE c.slug = 'mem-ria-ram'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'EVGA Fontes Premium Model 1967', 'evga-fontes-premium-model-1967-28', 703.79, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/evga-fontes-premium-model-1967-28/600/400'], '{"brand": "EVGA"}'::jsonb, 28
FROM ecommerce.categories c WHERE c.slug = 'fontes-de-alimenta-o'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'ZOTAC Placas Premium Model 7627', 'zotac-placas-premium-model-7627-29', 574.35, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/zotac-placas-premium-model-7627-29/600/400'], '{"brand": "ZOTAC"}'::jsonb, 43
FROM ecommerce.categories c WHERE c.slug = 'placas-gr-ficas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'be quiet! Fontes Premium Model 5577', 'be-quiet-fontes-premium-model-5577-30', 53.78, c.id, 'Chiptec', ARRAY['https://picsum.photos/seed/be-quiet-fontes-premium-model-5577-30/600/400'], '{"brand": "be quiet!"}'::jsonb, 16
FROM ecommerce.categories c WHERE c.slug = 'fontes-de-alimenta-o'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'AMD Ryzen Processadores Premium Model 7470', 'amd-ryzen-processadores-premium-model-7470-31', 132.48, c.id, 'InfoComputer', ARRAY['https://picsum.photos/seed/amd-ryzen-processadores-premium-model-7470-31/600/400'], '{"brand": "AMD Ryzen"}'::jsonb, 30
FROM ecommerce.categories c WHERE c.slug = 'processadores'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Fractal Design Caixas Premium Model 1944', 'fractal-design-caixas-premium-model-1944-32', 309.15, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/fractal-design-caixas-premium-model-1944-32/600/400'], '{"brand": "Fractal Design"}'::jsonb, 16
FROM ecommerce.categories c WHERE c.slug = 'caixas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'MSI Motherboards Premium Model 4503', 'msi-motherboards-premium-model-4503-33', 757.86, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/msi-motherboards-premium-model-4503-33/600/400'], '{"brand": "MSI"}'::jsonb, 43
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Gigabyte AORUS Placas Premium Model 8400', 'gigabyte-aorus-placas-premium-model-8400-34', 310.88, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/gigabyte-aorus-placas-premium-model-8400-34/600/400'], '{"brand": "Gigabyte AORUS"}'::jsonb, 2
FROM ecommerce.categories c WHERE c.slug = 'placas-gr-ficas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'AMD Ryzen Processadores Premium Model 2158', 'amd-ryzen-processadores-premium-model-2158-35', 605.60, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/amd-ryzen-processadores-premium-model-2158-35/600/400'], '{"brand": "AMD Ryzen"}'::jsonb, 5
FROM ecommerce.categories c WHERE c.slug = 'processadores'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'G.Skill Memória Premium Model 3593', 'g-skill-mem-ria-premium-model-3593-36', 216.41, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/g-skill-mem-ria-premium-model-3593-36/600/400'], '{"brand": "G.Skill"}'::jsonb, 27
FROM ecommerce.categories c WHERE c.slug = 'mem-ria-ram'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'MSI Gaming Placas Premium Model 5622', 'msi-gaming-placas-premium-model-5622-37', 538.16, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/msi-gaming-placas-premium-model-5622-37/600/400'], '{"brand": "MSI Gaming"}'::jsonb, 20
FROM ecommerce.categories c WHERE c.slug = 'placas-gr-ficas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Crucial Memória Premium Model 5373', 'crucial-mem-ria-premium-model-5373-38', 444.07, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/crucial-mem-ria-premium-model-5373-38/600/400'], '{"brand": "Crucial"}'::jsonb, 16
FROM ecommerce.categories c WHERE c.slug = 'mem-ria-ram'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'ASUS ROG Placas Premium Model 6918', 'asus-rog-placas-premium-model-6918-39', 785.79, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/asus-rog-placas-premium-model-6918-39/600/400'], '{"brand": "ASUS ROG"}'::jsonb, 3
FROM ecommerce.categories c WHERE c.slug = 'placas-gr-ficas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Intel Core Processadores Premium Model 4210', 'intel-core-processadores-premium-model-4210-40', 277.10, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/intel-core-processadores-premium-model-4210-40/600/400'], '{"brand": "Intel Core"}'::jsonb, 32
FROM ecommerce.categories c WHERE c.slug = 'processadores'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Crucial Armazenamento Premium Model 8901', 'crucial-armazenamento-premium-model-8901-41', 708.45, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/crucial-armazenamento-premium-model-8901-41/600/400'], '{"brand": "Crucial"}'::jsonb, 6
FROM ecommerce.categories c WHERE c.slug = 'armazenamento'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'be quiet! Fontes Premium Model 7292', 'be-quiet-fontes-premium-model-7292-42', 405.62, c.id, 'InfoComputer', ARRAY['https://picsum.photos/seed/be-quiet-fontes-premium-model-7292-42/600/400'], '{"brand": "be quiet!"}'::jsonb, 22
FROM ecommerce.categories c WHERE c.slug = 'fontes-de-alimenta-o'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'MSI Motherboards Premium Model 1980', 'msi-motherboards-premium-model-1980-43', 393.97, c.id, 'Chiptec', ARRAY['https://picsum.photos/seed/msi-motherboards-premium-model-1980-43/600/400'], '{"brand": "MSI"}'::jsonb, 43
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'WD_BLACK Armazenamento Premium Model 9303', 'wd-black-armazenamento-premium-model-9303-44', 269.49, c.id, 'InfoComputer', ARRAY['https://picsum.photos/seed/wd-black-armazenamento-premium-model-9303-44/600/400'], '{"brand": "WD_BLACK"}'::jsonb, 38
FROM ecommerce.categories c WHERE c.slug = 'armazenamento'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'NZXT Caixas Premium Model 1956', 'nzxt-caixas-premium-model-1956-45', 643.75, c.id, 'InfoComputer', ARRAY['https://picsum.photos/seed/nzxt-caixas-premium-model-1956-45/600/400'], '{"brand": "NZXT"}'::jsonb, 22
FROM ecommerce.categories c WHERE c.slug = 'caixas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Lian Li Caixas Premium Model 9673', 'lian-li-caixas-premium-model-9673-46', 692.38, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/lian-li-caixas-premium-model-9673-46/600/400'], '{"brand": "Lian Li"}'::jsonb, 12
FROM ecommerce.categories c WHERE c.slug = 'caixas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'ASUS Motherboards Premium Model 6906', 'asus-motherboards-premium-model-6906-47', 468.38, c.id, 'InfoComputer', ARRAY['https://picsum.photos/seed/asus-motherboards-premium-model-6906-47/600/400'], '{"brand": "ASUS"}'::jsonb, 46
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Corsair Memória Premium Model 6077', 'corsair-mem-ria-premium-model-6077-48', 395.96, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/corsair-mem-ria-premium-model-6077-48/600/400'], '{"brand": "Corsair"}'::jsonb, 26
FROM ecommerce.categories c WHERE c.slug = 'mem-ria-ram'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Sapphire Placas Premium Model 3769', 'sapphire-placas-premium-model-3769-49', 622.11, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/sapphire-placas-premium-model-3769-49/600/400'], '{"brand": "Sapphire"}'::jsonb, 32
FROM ecommerce.categories c WHERE c.slug = 'placas-gr-ficas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'MSI Motherboards Premium Model 9655', 'msi-motherboards-premium-model-9655-50', 585.23, c.id, 'Chiptec', ARRAY['https://picsum.photos/seed/msi-motherboards-premium-model-9655-50/600/400'], '{"brand": "MSI"}'::jsonb, 32
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Corsair Memória Premium Model 4874', 'corsair-mem-ria-premium-model-4874-51', 231.27, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/corsair-mem-ria-premium-model-4874-51/600/400'], '{"brand": "Corsair"}'::jsonb, 17
FROM ecommerce.categories c WHERE c.slug = 'mem-ria-ram'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'ASUS ROG Placas Premium Model 4420', 'asus-rog-placas-premium-model-4420-52', 380.19, c.id, 'InfoComputer', ARRAY['https://picsum.photos/seed/asus-rog-placas-premium-model-4420-52/600/400'], '{"brand": "ASUS ROG"}'::jsonb, 28
FROM ecommerce.categories c WHERE c.slug = 'placas-gr-ficas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Seagate Armazenamento Premium Model 6187', 'seagate-armazenamento-premium-model-6187-53', 150.88, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/seagate-armazenamento-premium-model-6187-53/600/400'], '{"brand": "Seagate"}'::jsonb, 29
FROM ecommerce.categories c WHERE c.slug = 'armazenamento'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'ASUS Motherboards Premium Model 8201', 'asus-motherboards-premium-model-8201-54', 298.85, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/asus-motherboards-premium-model-8201-54/600/400'], '{"brand": "ASUS"}'::jsonb, 38
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Sapphire Placas Premium Model 6840', 'sapphire-placas-premium-model-6840-55', 456.13, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/sapphire-placas-premium-model-6840-55/600/400'], '{"brand": "Sapphire"}'::jsonb, 20
FROM ecommerce.categories c WHERE c.slug = 'placas-gr-ficas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Seasonic Fontes Premium Model 8756', 'seasonic-fontes-premium-model-8756-56', 560.98, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/seasonic-fontes-premium-model-8756-56/600/400'], '{"brand": "Seasonic"}'::jsonb, 47
FROM ecommerce.categories c WHERE c.slug = 'fontes-de-alimenta-o'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Fractal Design Caixas Premium Model 9331', 'fractal-design-caixas-premium-model-9331-57', 223.49, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/fractal-design-caixas-premium-model-9331-57/600/400'], '{"brand": "Fractal Design"}'::jsonb, 14
FROM ecommerce.categories c WHERE c.slug = 'caixas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Gigabyte Motherboards Premium Model 2828', 'gigabyte-motherboards-premium-model-2828-58', 572.97, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/gigabyte-motherboards-premium-model-2828-58/600/400'], '{"brand": "Gigabyte"}'::jsonb, 16
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'AMD Ryzen Processadores Premium Model 7882', 'amd-ryzen-processadores-premium-model-7882-59', 479.43, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/amd-ryzen-processadores-premium-model-7882-59/600/400'], '{"brand": "AMD Ryzen"}'::jsonb, 32
FROM ecommerce.categories c WHERE c.slug = 'processadores'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Fractal Design Caixas Premium Model 3841', 'fractal-design-caixas-premium-model-3841-60', 255.32, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/fractal-design-caixas-premium-model-3841-60/600/400'], '{"brand": "Fractal Design"}'::jsonb, 35
FROM ecommerce.categories c WHERE c.slug = 'caixas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Crucial Armazenamento Premium Model 2842', 'crucial-armazenamento-premium-model-2842-61', 485.13, c.id, 'InfoComputer', ARRAY['https://picsum.photos/seed/crucial-armazenamento-premium-model-2842-61/600/400'], '{"brand": "Crucial"}'::jsonb, 6
FROM ecommerce.categories c WHERE c.slug = 'armazenamento'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'ASUS Motherboards Premium Model 1038', 'asus-motherboards-premium-model-1038-62', 377.78, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/asus-motherboards-premium-model-1038-62/600/400'], '{"brand": "ASUS"}'::jsonb, 27
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Sapphire Placas Premium Model 6527', 'sapphire-placas-premium-model-6527-63', 664.85, c.id, 'Chiptec', ARRAY['https://picsum.photos/seed/sapphire-placas-premium-model-6527-63/600/400'], '{"brand": "Sapphire"}'::jsonb, 8
FROM ecommerce.categories c WHERE c.slug = 'placas-gr-ficas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'ZOTAC Placas Premium Model 4015', 'zotac-placas-premium-model-4015-64', 780.81, c.id, 'Chiptec', ARRAY['https://picsum.photos/seed/zotac-placas-premium-model-4015-64/600/400'], '{"brand": "ZOTAC"}'::jsonb, 35
FROM ecommerce.categories c WHERE c.slug = 'placas-gr-ficas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'AMD Ryzen Processadores Premium Model 5690', 'amd-ryzen-processadores-premium-model-5690-65', 744.25, c.id, 'Chiptec', ARRAY['https://picsum.photos/seed/amd-ryzen-processadores-premium-model-5690-65/600/400'], '{"brand": "AMD Ryzen"}'::jsonb, 2
FROM ecommerce.categories c WHERE c.slug = 'processadores'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Corsair Caixas Premium Model 6716', 'corsair-caixas-premium-model-6716-66', 463.75, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/corsair-caixas-premium-model-6716-66/600/400'], '{"brand": "Corsair"}'::jsonb, 16
FROM ecommerce.categories c WHERE c.slug = 'caixas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'WD_BLACK Armazenamento Premium Model 1707', 'wd-black-armazenamento-premium-model-1707-67', 291.40, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/wd-black-armazenamento-premium-model-1707-67/600/400'], '{"brand": "WD_BLACK"}'::jsonb, 43
FROM ecommerce.categories c WHERE c.slug = 'armazenamento'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Seagate Armazenamento Premium Model 6854', 'seagate-armazenamento-premium-model-6854-68', 849.07, c.id, 'Chiptec', ARRAY['https://picsum.photos/seed/seagate-armazenamento-premium-model-6854-68/600/400'], '{"brand": "Seagate"}'::jsonb, 31
FROM ecommerce.categories c WHERE c.slug = 'armazenamento'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Fractal Design Caixas Premium Model 3206', 'fractal-design-caixas-premium-model-3206-69', 828.20, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/fractal-design-caixas-premium-model-3206-69/600/400'], '{"brand": "Fractal Design"}'::jsonb, 33
FROM ecommerce.categories c WHERE c.slug = 'caixas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'ASUS Motherboards Premium Model 9568', 'asus-motherboards-premium-model-9568-70', 629.73, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/asus-motherboards-premium-model-9568-70/600/400'], '{"brand": "ASUS"}'::jsonb, 45
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Sapphire Placas Premium Model 7732', 'sapphire-placas-premium-model-7732-71', 698.41, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/sapphire-placas-premium-model-7732-71/600/400'], '{"brand": "Sapphire"}'::jsonb, 24
FROM ecommerce.categories c WHERE c.slug = 'placas-gr-ficas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Crucial Armazenamento Premium Model 8714', 'crucial-armazenamento-premium-model-8714-72', 621.97, c.id, 'InfoComputer', ARRAY['https://picsum.photos/seed/crucial-armazenamento-premium-model-8714-72/600/400'], '{"brand": "Crucial"}'::jsonb, 8
FROM ecommerce.categories c WHERE c.slug = 'armazenamento'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Samsung Armazenamento Premium Model 6552', 'samsung-armazenamento-premium-model-6552-73', 328.27, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/samsung-armazenamento-premium-model-6552-73/600/400'], '{"brand": "Samsung"}'::jsonb, 45
FROM ecommerce.categories c WHERE c.slug = 'armazenamento'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'be quiet! Fontes Premium Model 7227', 'be-quiet-fontes-premium-model-7227-74', 391.04, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/be-quiet-fontes-premium-model-7227-74/600/400'], '{"brand": "be quiet!"}'::jsonb, 30
FROM ecommerce.categories c WHERE c.slug = 'fontes-de-alimenta-o'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Gigabyte AORUS Placas Premium Model 2215', 'gigabyte-aorus-placas-premium-model-2215-75', 71.24, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/gigabyte-aorus-placas-premium-model-2215-75/600/400'], '{"brand": "Gigabyte AORUS"}'::jsonb, 33
FROM ecommerce.categories c WHERE c.slug = 'placas-gr-ficas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'ASRock Motherboards Premium Model 4828', 'asrock-motherboards-premium-model-4828-76', 475.44, c.id, 'InfoComputer', ARRAY['https://picsum.photos/seed/asrock-motherboards-premium-model-4828-76/600/400'], '{"brand": "ASRock"}'::jsonb, 27
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Fractal Design Caixas Premium Model 9591', 'fractal-design-caixas-premium-model-9591-77', 752.99, c.id, 'Chiptec', ARRAY['https://picsum.photos/seed/fractal-design-caixas-premium-model-9591-77/600/400'], '{"brand": "Fractal Design"}'::jsonb, 7
FROM ecommerce.categories c WHERE c.slug = 'caixas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'ASUS Motherboards Premium Model 9529', 'asus-motherboards-premium-model-9529-78', 555.58, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/asus-motherboards-premium-model-9529-78/600/400'], '{"brand": "ASUS"}'::jsonb, 37
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'be quiet! Fontes Premium Model 4562', 'be-quiet-fontes-premium-model-4562-79', 244.97, c.id, 'InfoComputer', ARRAY['https://picsum.photos/seed/be-quiet-fontes-premium-model-4562-79/600/400'], '{"brand": "be quiet!"}'::jsonb, 39
FROM ecommerce.categories c WHERE c.slug = 'fontes-de-alimenta-o'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Gigabyte Motherboards Premium Model 7284', 'gigabyte-motherboards-premium-model-7284-80', 712.22, c.id, 'Chiptec', ARRAY['https://picsum.photos/seed/gigabyte-motherboards-premium-model-7284-80/600/400'], '{"brand": "Gigabyte"}'::jsonb, 18
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Corsair Memória Premium Model 6022', 'corsair-mem-ria-premium-model-6022-81', 335.79, c.id, 'InfoComputer', ARRAY['https://picsum.photos/seed/corsair-mem-ria-premium-model-6022-81/600/400'], '{"brand": "Corsair"}'::jsonb, 43
FROM ecommerce.categories c WHERE c.slug = 'mem-ria-ram'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'ASUS Motherboards Premium Model 9960', 'asus-motherboards-premium-model-9960-82', 58.36, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/asus-motherboards-premium-model-9960-82/600/400'], '{"brand": "ASUS"}'::jsonb, 17
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Gigabyte Motherboards Premium Model 7024', 'gigabyte-motherboards-premium-model-7024-83', 828.04, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/gigabyte-motherboards-premium-model-7024-83/600/400'], '{"brand": "Gigabyte"}'::jsonb, 35
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Sapphire Placas Premium Model 4411', 'sapphire-placas-premium-model-4411-84', 571.05, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/sapphire-placas-premium-model-4411-84/600/400'], '{"brand": "Sapphire"}'::jsonb, 31
FROM ecommerce.categories c WHERE c.slug = 'placas-gr-ficas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Crucial Memória Premium Model 3494', 'crucial-mem-ria-premium-model-3494-85', 337.35, c.id, 'InfoComputer', ARRAY['https://picsum.photos/seed/crucial-mem-ria-premium-model-3494-85/600/400'], '{"brand": "Crucial"}'::jsonb, 42
FROM ecommerce.categories c WHERE c.slug = 'mem-ria-ram'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'G.Skill Memória Premium Model 9161', 'g-skill-mem-ria-premium-model-9161-86', 363.64, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/g-skill-mem-ria-premium-model-9161-86/600/400'], '{"brand": "G.Skill"}'::jsonb, 42
FROM ecommerce.categories c WHERE c.slug = 'mem-ria-ram'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Crucial Armazenamento Premium Model 9336', 'crucial-armazenamento-premium-model-9336-87', 762.09, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/crucial-armazenamento-premium-model-9336-87/600/400'], '{"brand": "Crucial"}'::jsonb, 34
FROM ecommerce.categories c WHERE c.slug = 'armazenamento'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Gigabyte Motherboards Premium Model 5954', 'gigabyte-motherboards-premium-model-5954-88', 498.38, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/gigabyte-motherboards-premium-model-5954-88/600/400'], '{"brand": "Gigabyte"}'::jsonb, 12
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Corsair Memória Premium Model 9446', 'corsair-mem-ria-premium-model-9446-89', 458.52, c.id, 'InfoComputer', ARRAY['https://picsum.photos/seed/corsair-mem-ria-premium-model-9446-89/600/400'], '{"brand": "Corsair"}'::jsonb, 26
FROM ecommerce.categories c WHERE c.slug = 'mem-ria-ram'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Crucial Armazenamento Premium Model 3571', 'crucial-armazenamento-premium-model-3571-90', 679.27, c.id, 'Chiptec', ARRAY['https://picsum.photos/seed/crucial-armazenamento-premium-model-3571-90/600/400'], '{"brand": "Crucial"}'::jsonb, 7
FROM ecommerce.categories c WHERE c.slug = 'armazenamento'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Crucial Memória Premium Model 2963', 'crucial-mem-ria-premium-model-2963-91', 76.17, c.id, 'InfoComputer', ARRAY['https://picsum.photos/seed/crucial-mem-ria-premium-model-2963-91/600/400'], '{"brand": "Crucial"}'::jsonb, 4
FROM ecommerce.categories c WHERE c.slug = 'mem-ria-ram'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Gigabyte Motherboards Premium Model 7174', 'gigabyte-motherboards-premium-model-7174-92', 72.80, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/gigabyte-motherboards-premium-model-7174-92/600/400'], '{"brand": "Gigabyte"}'::jsonb, 35
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Corsair Memória Premium Model 9898', 'corsair-mem-ria-premium-model-9898-93', 211.53, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/corsair-mem-ria-premium-model-9898-93/600/400'], '{"brand": "Corsair"}'::jsonb, 17
FROM ecommerce.categories c WHERE c.slug = 'mem-ria-ram'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'G.Skill Memória Premium Model 4963', 'g-skill-mem-ria-premium-model-4963-94', 699.88, c.id, 'Chiptec', ARRAY['https://picsum.photos/seed/g-skill-mem-ria-premium-model-4963-94/600/400'], '{"brand": "G.Skill"}'::jsonb, 13
FROM ecommerce.categories c WHERE c.slug = 'mem-ria-ram'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Intel Core Processadores Premium Model 7113', 'intel-core-processadores-premium-model-7113-95', 362.71, c.id, 'Chiptec', ARRAY['https://picsum.photos/seed/intel-core-processadores-premium-model-7113-95/600/400'], '{"brand": "Intel Core"}'::jsonb, 47
FROM ecommerce.categories c WHERE c.slug = 'processadores'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Sapphire Placas Premium Model 7880', 'sapphire-placas-premium-model-7880-96', 60.79, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/sapphire-placas-premium-model-7880-96/600/400'], '{"brand": "Sapphire"}'::jsonb, 28
FROM ecommerce.categories c WHERE c.slug = 'placas-gr-ficas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'G.Skill Memória Premium Model 9463', 'g-skill-mem-ria-premium-model-9463-97', 367.12, c.id, 'Chiptec', ARRAY['https://picsum.photos/seed/g-skill-mem-ria-premium-model-9463-97/600/400'], '{"brand": "G.Skill"}'::jsonb, 26
FROM ecommerce.categories c WHERE c.slug = 'mem-ria-ram'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Sapphire Placas Premium Model 1802', 'sapphire-placas-premium-model-1802-98', 398.21, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/sapphire-placas-premium-model-1802-98/600/400'], '{"brand": "Sapphire"}'::jsonb, 31
FROM ecommerce.categories c WHERE c.slug = 'placas-gr-ficas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Gigabyte Motherboards Premium Model 3659', 'gigabyte-motherboards-premium-model-3659-99', 148.95, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/gigabyte-motherboards-premium-model-3659-99/600/400'], '{"brand": "Gigabyte"}'::jsonb, 1
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'ASRock Motherboards Premium Model 1525', 'asrock-motherboards-premium-model-1525-100', 501.70, c.id, 'InfoComputer', ARRAY['https://picsum.photos/seed/asrock-motherboards-premium-model-1525-100/600/400'], '{"brand": "ASRock"}'::jsonb, 1
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'ZOTAC Placas Premium Model 9146', 'zotac-placas-premium-model-9146-101', 262.62, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/zotac-placas-premium-model-9146-101/600/400'], '{"brand": "ZOTAC"}'::jsonb, 2
FROM ecommerce.categories c WHERE c.slug = 'placas-gr-ficas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Crucial Memória Premium Model 9012', 'crucial-mem-ria-premium-model-9012-102', 131.15, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/crucial-mem-ria-premium-model-9012-102/600/400'], '{"brand": "Crucial"}'::jsonb, 19
FROM ecommerce.categories c WHERE c.slug = 'mem-ria-ram'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Corsair Memória Premium Model 7394', 'corsair-mem-ria-premium-model-7394-103', 360.90, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/corsair-mem-ria-premium-model-7394-103/600/400'], '{"brand": "Corsair"}'::jsonb, 6
FROM ecommerce.categories c WHERE c.slug = 'mem-ria-ram'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'ASRock Motherboards Premium Model 2546', 'asrock-motherboards-premium-model-2546-104', 723.70, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/asrock-motherboards-premium-model-2546-104/600/400'], '{"brand": "ASRock"}'::jsonb, 18
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Lian Li Caixas Premium Model 1865', 'lian-li-caixas-premium-model-1865-105', 819.23, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/lian-li-caixas-premium-model-1865-105/600/400'], '{"brand": "Lian Li"}'::jsonb, 21
FROM ecommerce.categories c WHERE c.slug = 'caixas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Corsair Caixas Premium Model 7561', 'corsair-caixas-premium-model-7561-106', 274.68, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/corsair-caixas-premium-model-7561-106/600/400'], '{"brand": "Corsair"}'::jsonb, 14
FROM ecommerce.categories c WHERE c.slug = 'caixas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Intel Core Processadores Premium Model 8290', 'intel-core-processadores-premium-model-8290-107', 150.59, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/intel-core-processadores-premium-model-8290-107/600/400'], '{"brand": "Intel Core"}'::jsonb, 8
FROM ecommerce.categories c WHERE c.slug = 'processadores'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'MSI Gaming Placas Premium Model 9859', 'msi-gaming-placas-premium-model-9859-108', 518.24, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/msi-gaming-placas-premium-model-9859-108/600/400'], '{"brand": "MSI Gaming"}'::jsonb, 22
FROM ecommerce.categories c WHERE c.slug = 'placas-gr-ficas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Fractal Design Caixas Premium Model 9714', 'fractal-design-caixas-premium-model-9714-109', 410.38, c.id, 'InfoComputer', ARRAY['https://picsum.photos/seed/fractal-design-caixas-premium-model-9714-109/600/400'], '{"brand": "Fractal Design"}'::jsonb, 20
FROM ecommerce.categories c WHERE c.slug = 'caixas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Seagate Armazenamento Premium Model 1439', 'seagate-armazenamento-premium-model-1439-110', 457.40, c.id, 'Chiptec', ARRAY['https://picsum.photos/seed/seagate-armazenamento-premium-model-1439-110/600/400'], '{"brand": "Seagate"}'::jsonb, 23
FROM ecommerce.categories c WHERE c.slug = 'armazenamento'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Corsair Fontes Premium Model 1528', 'corsair-fontes-premium-model-1528-111', 70.55, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/corsair-fontes-premium-model-1528-111/600/400'], '{"brand": "Corsair"}'::jsonb, 3
FROM ecommerce.categories c WHERE c.slug = 'fontes-de-alimenta-o'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'ASUS Motherboards Premium Model 9718', 'asus-motherboards-premium-model-9718-112', 837.24, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/asus-motherboards-premium-model-9718-112/600/400'], '{"brand": "ASUS"}'::jsonb, 45
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Crucial Armazenamento Premium Model 6099', 'crucial-armazenamento-premium-model-6099-113', 278.36, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/crucial-armazenamento-premium-model-6099-113/600/400'], '{"brand": "Crucial"}'::jsonb, 11
FROM ecommerce.categories c WHERE c.slug = 'armazenamento'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Seagate Armazenamento Premium Model 7091', 'seagate-armazenamento-premium-model-7091-114', 86.00, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/seagate-armazenamento-premium-model-7091-114/600/400'], '{"brand": "Seagate"}'::jsonb, 8
FROM ecommerce.categories c WHERE c.slug = 'armazenamento'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Intel Core Processadores Premium Model 7876', 'intel-core-processadores-premium-model-7876-115', 172.34, c.id, 'InfoComputer', ARRAY['https://picsum.photos/seed/intel-core-processadores-premium-model-7876-115/600/400'], '{"brand": "Intel Core"}'::jsonb, 39
FROM ecommerce.categories c WHERE c.slug = 'processadores'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Intel Core Processadores Premium Model 7529', 'intel-core-processadores-premium-model-7529-116', 773.13, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/intel-core-processadores-premium-model-7529-116/600/400'], '{"brand": "Intel Core"}'::jsonb, 39
FROM ecommerce.categories c WHERE c.slug = 'processadores'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'MSI Motherboards Premium Model 1753', 'msi-motherboards-premium-model-1753-117', 359.09, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/msi-motherboards-premium-model-1753-117/600/400'], '{"brand": "MSI"}'::jsonb, 41
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Fractal Design Caixas Premium Model 6352', 'fractal-design-caixas-premium-model-6352-118', 183.41, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/fractal-design-caixas-premium-model-6352-118/600/400'], '{"brand": "Fractal Design"}'::jsonb, 39
FROM ecommerce.categories c WHERE c.slug = 'caixas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'be quiet! Fontes Premium Model 1287', 'be-quiet-fontes-premium-model-1287-119', 281.35, c.id, 'Chiptec', ARRAY['https://picsum.photos/seed/be-quiet-fontes-premium-model-1287-119/600/400'], '{"brand": "be quiet!"}'::jsonb, 6
FROM ecommerce.categories c WHERE c.slug = 'fontes-de-alimenta-o'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'ASUS Motherboards Premium Model 9721', 'asus-motherboards-premium-model-9721-120', 626.01, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/asus-motherboards-premium-model-9721-120/600/400'], '{"brand": "ASUS"}'::jsonb, 13
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'ASRock Motherboards Premium Model 2100', 'asrock-motherboards-premium-model-2100-121', 493.05, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/asrock-motherboards-premium-model-2100-121/600/400'], '{"brand": "ASRock"}'::jsonb, 23
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Corsair Memória Premium Model 2995', 'corsair-mem-ria-premium-model-2995-122', 53.52, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/corsair-mem-ria-premium-model-2995-122/600/400'], '{"brand": "Corsair"}'::jsonb, 8
FROM ecommerce.categories c WHERE c.slug = 'mem-ria-ram'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Fractal Design Caixas Premium Model 6533', 'fractal-design-caixas-premium-model-6533-123', 121.03, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/fractal-design-caixas-premium-model-6533-123/600/400'], '{"brand": "Fractal Design"}'::jsonb, 45
FROM ecommerce.categories c WHERE c.slug = 'caixas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Crucial Armazenamento Premium Model 5307', 'crucial-armazenamento-premium-model-5307-124', 206.20, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/crucial-armazenamento-premium-model-5307-124/600/400'], '{"brand": "Crucial"}'::jsonb, 16
FROM ecommerce.categories c WHERE c.slug = 'armazenamento'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'MSI Motherboards Premium Model 3624', 'msi-motherboards-premium-model-3624-125', 104.95, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/msi-motherboards-premium-model-3624-125/600/400'], '{"brand": "MSI"}'::jsonb, 28
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Sapphire Placas Premium Model 7184', 'sapphire-placas-premium-model-7184-126', 636.72, c.id, 'Chiptec', ARRAY['https://picsum.photos/seed/sapphire-placas-premium-model-7184-126/600/400'], '{"brand": "Sapphire"}'::jsonb, 1
FROM ecommerce.categories c WHERE c.slug = 'placas-gr-ficas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'EVGA Fontes Premium Model 9277', 'evga-fontes-premium-model-9277-127', 113.42, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/evga-fontes-premium-model-9277-127/600/400'], '{"brand": "EVGA"}'::jsonb, 23
FROM ecommerce.categories c WHERE c.slug = 'fontes-de-alimenta-o'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Kingston FURY Memória Premium Model 3178', 'kingston-fury-mem-ria-premium-model-3178-128', 568.66, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/kingston-fury-mem-ria-premium-model-3178-128/600/400'], '{"brand": "Kingston FURY"}'::jsonb, 2
FROM ecommerce.categories c WHERE c.slug = 'mem-ria-ram'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'MSI Motherboards Premium Model 7515', 'msi-motherboards-premium-model-7515-129', 825.01, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/msi-motherboards-premium-model-7515-129/600/400'], '{"brand": "MSI"}'::jsonb, 15
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Kingston FURY Memória Premium Model 1329', 'kingston-fury-mem-ria-premium-model-1329-130', 588.63, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/kingston-fury-mem-ria-premium-model-1329-130/600/400'], '{"brand": "Kingston FURY"}'::jsonb, 47
FROM ecommerce.categories c WHERE c.slug = 'mem-ria-ram'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'ASRock Motherboards Premium Model 6775', 'asrock-motherboards-premium-model-6775-131', 125.62, c.id, 'Chiptec', ARRAY['https://picsum.photos/seed/asrock-motherboards-premium-model-6775-131/600/400'], '{"brand": "ASRock"}'::jsonb, 24
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'G.Skill Memória Premium Model 8582', 'g-skill-mem-ria-premium-model-8582-132', 583.04, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/g-skill-mem-ria-premium-model-8582-132/600/400'], '{"brand": "G.Skill"}'::jsonb, 29
FROM ecommerce.categories c WHERE c.slug = 'mem-ria-ram'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'EVGA Fontes Premium Model 4584', 'evga-fontes-premium-model-4584-133', 659.40, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/evga-fontes-premium-model-4584-133/600/400'], '{"brand": "EVGA"}'::jsonb, 15
FROM ecommerce.categories c WHERE c.slug = 'fontes-de-alimenta-o'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'ZOTAC Placas Premium Model 2013', 'zotac-placas-premium-model-2013-134', 100.44, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/zotac-placas-premium-model-2013-134/600/400'], '{"brand": "ZOTAC"}'::jsonb, 10
FROM ecommerce.categories c WHERE c.slug = 'placas-gr-ficas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Crucial Armazenamento Premium Model 5316', 'crucial-armazenamento-premium-model-5316-135', 561.13, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/crucial-armazenamento-premium-model-5316-135/600/400'], '{"brand": "Crucial"}'::jsonb, 35
FROM ecommerce.categories c WHERE c.slug = 'armazenamento'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Fractal Design Caixas Premium Model 9263', 'fractal-design-caixas-premium-model-9263-136', 205.54, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/fractal-design-caixas-premium-model-9263-136/600/400'], '{"brand": "Fractal Design"}'::jsonb, 21
FROM ecommerce.categories c WHERE c.slug = 'caixas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Corsair Fontes Premium Model 9086', 'corsair-fontes-premium-model-9086-137', 320.31, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/corsair-fontes-premium-model-9086-137/600/400'], '{"brand": "Corsair"}'::jsonb, 41
FROM ecommerce.categories c WHERE c.slug = 'fontes-de-alimenta-o'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'AMD Ryzen Processadores Premium Model 6441', 'amd-ryzen-processadores-premium-model-6441-138', 641.72, c.id, 'InfoComputer', ARRAY['https://picsum.photos/seed/amd-ryzen-processadores-premium-model-6441-138/600/400'], '{"brand": "AMD Ryzen"}'::jsonb, 26
FROM ecommerce.categories c WHERE c.slug = 'processadores'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Crucial Memória Premium Model 9634', 'crucial-mem-ria-premium-model-9634-139', 840.13, c.id, 'Chiptec', ARRAY['https://picsum.photos/seed/crucial-mem-ria-premium-model-9634-139/600/400'], '{"brand": "Crucial"}'::jsonb, 8
FROM ecommerce.categories c WHERE c.slug = 'mem-ria-ram'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Corsair Fontes Premium Model 3196', 'corsair-fontes-premium-model-3196-140', 401.93, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/corsair-fontes-premium-model-3196-140/600/400'], '{"brand": "Corsair"}'::jsonb, 1
FROM ecommerce.categories c WHERE c.slug = 'fontes-de-alimenta-o'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Crucial Memória Premium Model 8111', 'crucial-mem-ria-premium-model-8111-141', 246.00, c.id, 'InfoComputer', ARRAY['https://picsum.photos/seed/crucial-mem-ria-premium-model-8111-141/600/400'], '{"brand": "Crucial"}'::jsonb, 32
FROM ecommerce.categories c WHERE c.slug = 'mem-ria-ram'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'MSI Motherboards Premium Model 1272', 'msi-motherboards-premium-model-1272-142', 622.29, c.id, 'InfoComputer', ARRAY['https://picsum.photos/seed/msi-motherboards-premium-model-1272-142/600/400'], '{"brand": "MSI"}'::jsonb, 49
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Seagate Armazenamento Premium Model 5663', 'seagate-armazenamento-premium-model-5663-143', 573.61, c.id, 'InfoComputer', ARRAY['https://picsum.photos/seed/seagate-armazenamento-premium-model-5663-143/600/400'], '{"brand": "Seagate"}'::jsonb, 49
FROM ecommerce.categories c WHERE c.slug = 'armazenamento'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Intel Core Processadores Premium Model 1350', 'intel-core-processadores-premium-model-1350-144', 527.84, c.id, 'InfoComputer', ARRAY['https://picsum.photos/seed/intel-core-processadores-premium-model-1350-144/600/400'], '{"brand": "Intel Core"}'::jsonb, 35
FROM ecommerce.categories c WHERE c.slug = 'processadores'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'AMD Ryzen Processadores Premium Model 6780', 'amd-ryzen-processadores-premium-model-6780-145', 323.63, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/amd-ryzen-processadores-premium-model-6780-145/600/400'], '{"brand": "AMD Ryzen"}'::jsonb, 8
FROM ecommerce.categories c WHERE c.slug = 'processadores'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Corsair Caixas Premium Model 8682', 'corsair-caixas-premium-model-8682-146', 831.56, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/corsair-caixas-premium-model-8682-146/600/400'], '{"brand": "Corsair"}'::jsonb, 7
FROM ecommerce.categories c WHERE c.slug = 'caixas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'G.Skill Memória Premium Model 7074', 'g-skill-mem-ria-premium-model-7074-147', 350.57, c.id, 'InfoComputer', ARRAY['https://picsum.photos/seed/g-skill-mem-ria-premium-model-7074-147/600/400'], '{"brand": "G.Skill"}'::jsonb, 40
FROM ecommerce.categories c WHERE c.slug = 'mem-ria-ram'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'MSI Gaming Placas Premium Model 9694', 'msi-gaming-placas-premium-model-9694-148', 687.94, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/msi-gaming-placas-premium-model-9694-148/600/400'], '{"brand": "MSI Gaming"}'::jsonb, 32
FROM ecommerce.categories c WHERE c.slug = 'placas-gr-ficas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Gigabyte Motherboards Premium Model 9164', 'gigabyte-motherboards-premium-model-9164-149', 58.43, c.id, 'InfoComputer', ARRAY['https://picsum.photos/seed/gigabyte-motherboards-premium-model-9164-149/600/400'], '{"brand": "Gigabyte"}'::jsonb, 46
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Samsung Armazenamento Premium Model 3036', 'samsung-armazenamento-premium-model-3036-150', 472.93, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/samsung-armazenamento-premium-model-3036-150/600/400'], '{"brand": "Samsung"}'::jsonb, 33
FROM ecommerce.categories c WHERE c.slug = 'armazenamento'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Crucial Armazenamento Premium Model 1756', 'crucial-armazenamento-premium-model-1756-151', 772.56, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/crucial-armazenamento-premium-model-1756-151/600/400'], '{"brand": "Crucial"}'::jsonb, 31
FROM ecommerce.categories c WHERE c.slug = 'armazenamento'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Corsair Memória Premium Model 6135', 'corsair-mem-ria-premium-model-6135-152', 518.38, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/corsair-mem-ria-premium-model-6135-152/600/400'], '{"brand": "Corsair"}'::jsonb, 13
FROM ecommerce.categories c WHERE c.slug = 'mem-ria-ram'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'AMD Ryzen Processadores Premium Model 2827', 'amd-ryzen-processadores-premium-model-2827-153', 519.31, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/amd-ryzen-processadores-premium-model-2827-153/600/400'], '{"brand": "AMD Ryzen"}'::jsonb, 3
FROM ecommerce.categories c WHERE c.slug = 'processadores'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'NZXT Caixas Premium Model 3872', 'nzxt-caixas-premium-model-3872-154', 449.41, c.id, 'InfoComputer', ARRAY['https://picsum.photos/seed/nzxt-caixas-premium-model-3872-154/600/400'], '{"brand": "NZXT"}'::jsonb, 13
FROM ecommerce.categories c WHERE c.slug = 'caixas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'EVGA Fontes Premium Model 6562', 'evga-fontes-premium-model-6562-155', 178.30, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/evga-fontes-premium-model-6562-155/600/400'], '{"brand": "EVGA"}'::jsonb, 24
FROM ecommerce.categories c WHERE c.slug = 'fontes-de-alimenta-o'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Corsair Memória Premium Model 7546', 'corsair-mem-ria-premium-model-7546-156', 239.93, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/corsair-mem-ria-premium-model-7546-156/600/400'], '{"brand": "Corsair"}'::jsonb, 42
FROM ecommerce.categories c WHERE c.slug = 'mem-ria-ram'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'ASUS Motherboards Premium Model 9245', 'asus-motherboards-premium-model-9245-157', 807.28, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/asus-motherboards-premium-model-9245-157/600/400'], '{"brand": "ASUS"}'::jsonb, 41
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'G.Skill Memória Premium Model 3913', 'g-skill-mem-ria-premium-model-3913-158', 723.81, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/g-skill-mem-ria-premium-model-3913-158/600/400'], '{"brand": "G.Skill"}'::jsonb, 16
FROM ecommerce.categories c WHERE c.slug = 'mem-ria-ram'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'MSI Gaming Placas Premium Model 3650', 'msi-gaming-placas-premium-model-3650-159', 304.51, c.id, 'InfoComputer', ARRAY['https://picsum.photos/seed/msi-gaming-placas-premium-model-3650-159/600/400'], '{"brand": "MSI Gaming"}'::jsonb, 5
FROM ecommerce.categories c WHERE c.slug = 'placas-gr-ficas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'ASUS ROG Placas Premium Model 9497', 'asus-rog-placas-premium-model-9497-160', 451.26, c.id, 'InfoComputer', ARRAY['https://picsum.photos/seed/asus-rog-placas-premium-model-9497-160/600/400'], '{"brand": "ASUS ROG"}'::jsonb, 8
FROM ecommerce.categories c WHERE c.slug = 'placas-gr-ficas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Fractal Design Caixas Premium Model 8013', 'fractal-design-caixas-premium-model-8013-161', 792.88, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/fractal-design-caixas-premium-model-8013-161/600/400'], '{"brand": "Fractal Design"}'::jsonb, 10
FROM ecommerce.categories c WHERE c.slug = 'caixas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'G.Skill Memória Premium Model 7660', 'g-skill-mem-ria-premium-model-7660-162', 550.67, c.id, 'Chiptec', ARRAY['https://picsum.photos/seed/g-skill-mem-ria-premium-model-7660-162/600/400'], '{"brand": "G.Skill"}'::jsonb, 26
FROM ecommerce.categories c WHERE c.slug = 'mem-ria-ram'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'WD_BLACK Armazenamento Premium Model 5821', 'wd-black-armazenamento-premium-model-5821-163', 564.17, c.id, 'InfoComputer', ARRAY['https://picsum.photos/seed/wd-black-armazenamento-premium-model-5821-163/600/400'], '{"brand": "WD_BLACK"}'::jsonb, 8
FROM ecommerce.categories c WHERE c.slug = 'armazenamento'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'AMD Ryzen Processadores Premium Model 1622', 'amd-ryzen-processadores-premium-model-1622-164', 848.43, c.id, 'Chiptec', ARRAY['https://picsum.photos/seed/amd-ryzen-processadores-premium-model-1622-164/600/400'], '{"brand": "AMD Ryzen"}'::jsonb, 32
FROM ecommerce.categories c WHERE c.slug = 'processadores'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Kingston FURY Memória Premium Model 5862', 'kingston-fury-mem-ria-premium-model-5862-165', 662.63, c.id, 'Chiptec', ARRAY['https://picsum.photos/seed/kingston-fury-mem-ria-premium-model-5862-165/600/400'], '{"brand": "Kingston FURY"}'::jsonb, 15
FROM ecommerce.categories c WHERE c.slug = 'mem-ria-ram'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Seagate Armazenamento Premium Model 3920', 'seagate-armazenamento-premium-model-3920-166', 361.69, c.id, 'Chiptec', ARRAY['https://picsum.photos/seed/seagate-armazenamento-premium-model-3920-166/600/400'], '{"brand": "Seagate"}'::jsonb, 20
FROM ecommerce.categories c WHERE c.slug = 'armazenamento'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Crucial Memória Premium Model 7782', 'crucial-mem-ria-premium-model-7782-167', 751.63, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/crucial-mem-ria-premium-model-7782-167/600/400'], '{"brand": "Crucial"}'::jsonb, 36
FROM ecommerce.categories c WHERE c.slug = 'mem-ria-ram'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Fractal Design Caixas Premium Model 9962', 'fractal-design-caixas-premium-model-9962-168', 738.01, c.id, 'Chiptec', ARRAY['https://picsum.photos/seed/fractal-design-caixas-premium-model-9962-168/600/400'], '{"brand": "Fractal Design"}'::jsonb, 19
FROM ecommerce.categories c WHERE c.slug = 'caixas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Intel Core Processadores Premium Model 5233', 'intel-core-processadores-premium-model-5233-169', 638.54, c.id, 'Chiptec', ARRAY['https://picsum.photos/seed/intel-core-processadores-premium-model-5233-169/600/400'], '{"brand": "Intel Core"}'::jsonb, 5
FROM ecommerce.categories c WHERE c.slug = 'processadores'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'MSI Gaming Placas Premium Model 1321', 'msi-gaming-placas-premium-model-1321-170', 626.11, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/msi-gaming-placas-premium-model-1321-170/600/400'], '{"brand": "MSI Gaming"}'::jsonb, 20
FROM ecommerce.categories c WHERE c.slug = 'placas-gr-ficas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Fractal Design Caixas Premium Model 8236', 'fractal-design-caixas-premium-model-8236-171', 572.25, c.id, 'Chiptec', ARRAY['https://picsum.photos/seed/fractal-design-caixas-premium-model-8236-171/600/400'], '{"brand": "Fractal Design"}'::jsonb, 14
FROM ecommerce.categories c WHERE c.slug = 'caixas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'MSI Motherboards Premium Model 6979', 'msi-motherboards-premium-model-6979-172', 328.75, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/msi-motherboards-premium-model-6979-172/600/400'], '{"brand": "MSI"}'::jsonb, 25
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Gigabyte AORUS Placas Premium Model 8425', 'gigabyte-aorus-placas-premium-model-8425-173', 440.36, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/gigabyte-aorus-placas-premium-model-8425-173/600/400'], '{"brand": "Gigabyte AORUS"}'::jsonb, 16
FROM ecommerce.categories c WHERE c.slug = 'placas-gr-ficas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Corsair Memória Premium Model 9832', 'corsair-mem-ria-premium-model-9832-174', 655.04, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/corsair-mem-ria-premium-model-9832-174/600/400'], '{"brand": "Corsair"}'::jsonb, 21
FROM ecommerce.categories c WHERE c.slug = 'mem-ria-ram'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'MSI Motherboards Premium Model 9906', 'msi-motherboards-premium-model-9906-175', 379.56, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/msi-motherboards-premium-model-9906-175/600/400'], '{"brand": "MSI"}'::jsonb, 9
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'ASRock Motherboards Premium Model 3829', 'asrock-motherboards-premium-model-3829-176', 813.09, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/asrock-motherboards-premium-model-3829-176/600/400'], '{"brand": "ASRock"}'::jsonb, 29
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Kingston FURY Memória Premium Model 4536', 'kingston-fury-mem-ria-premium-model-4536-177', 424.66, c.id, 'InfoComputer', ARRAY['https://picsum.photos/seed/kingston-fury-mem-ria-premium-model-4536-177/600/400'], '{"brand": "Kingston FURY"}'::jsonb, 45
FROM ecommerce.categories c WHERE c.slug = 'mem-ria-ram'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'EVGA Fontes Premium Model 8292', 'evga-fontes-premium-model-8292-178', 670.25, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/evga-fontes-premium-model-8292-178/600/400'], '{"brand": "EVGA"}'::jsonb, 1
FROM ecommerce.categories c WHERE c.slug = 'fontes-de-alimenta-o'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Corsair Caixas Premium Model 2196', 'corsair-caixas-premium-model-2196-179', 109.69, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/corsair-caixas-premium-model-2196-179/600/400'], '{"brand": "Corsair"}'::jsonb, 0
FROM ecommerce.categories c WHERE c.slug = 'caixas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Kingston FURY Memória Premium Model 1985', 'kingston-fury-mem-ria-premium-model-1985-180', 547.61, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/kingston-fury-mem-ria-premium-model-1985-180/600/400'], '{"brand": "Kingston FURY"}'::jsonb, 4
FROM ecommerce.categories c WHERE c.slug = 'mem-ria-ram'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Lian Li Caixas Premium Model 3959', 'lian-li-caixas-premium-model-3959-181', 609.51, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/lian-li-caixas-premium-model-3959-181/600/400'], '{"brand": "Lian Li"}'::jsonb, 6
FROM ecommerce.categories c WHERE c.slug = 'caixas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Samsung Armazenamento Premium Model 6107', 'samsung-armazenamento-premium-model-6107-182', 293.82, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/samsung-armazenamento-premium-model-6107-182/600/400'], '{"brand": "Samsung"}'::jsonb, 26
FROM ecommerce.categories c WHERE c.slug = 'armazenamento'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Gigabyte Motherboards Premium Model 7339', 'gigabyte-motherboards-premium-model-7339-183', 318.58, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/gigabyte-motherboards-premium-model-7339-183/600/400'], '{"brand": "Gigabyte"}'::jsonb, 15
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Intel Core Processadores Premium Model 9589', 'intel-core-processadores-premium-model-9589-184', 58.01, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/intel-core-processadores-premium-model-9589-184/600/400'], '{"brand": "Intel Core"}'::jsonb, 28
FROM ecommerce.categories c WHERE c.slug = 'processadores'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'MSI Motherboards Premium Model 2445', 'msi-motherboards-premium-model-2445-185', 679.52, c.id, 'InfoComputer', ARRAY['https://picsum.photos/seed/msi-motherboards-premium-model-2445-185/600/400'], '{"brand": "MSI"}'::jsonb, 30
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Gigabyte Motherboards Premium Model 5633', 'gigabyte-motherboards-premium-model-5633-186', 566.14, c.id, 'Chiptec', ARRAY['https://picsum.photos/seed/gigabyte-motherboards-premium-model-5633-186/600/400'], '{"brand": "Gigabyte"}'::jsonb, 38
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Gigabyte Motherboards Premium Model 6877', 'gigabyte-motherboards-premium-model-6877-187', 322.74, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/gigabyte-motherboards-premium-model-6877-187/600/400'], '{"brand": "Gigabyte"}'::jsonb, 46
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Gigabyte AORUS Placas Premium Model 1071', 'gigabyte-aorus-placas-premium-model-1071-188', 592.07, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/gigabyte-aorus-placas-premium-model-1071-188/600/400'], '{"brand": "Gigabyte AORUS"}'::jsonb, 38
FROM ecommerce.categories c WHERE c.slug = 'placas-gr-ficas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'ASRock Motherboards Premium Model 4646', 'asrock-motherboards-premium-model-4646-189', 188.27, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/asrock-motherboards-premium-model-4646-189/600/400'], '{"brand": "ASRock"}'::jsonb, 45
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'AMD Ryzen Processadores Premium Model 7452', 'amd-ryzen-processadores-premium-model-7452-190', 572.34, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/amd-ryzen-processadores-premium-model-7452-190/600/400'], '{"brand": "AMD Ryzen"}'::jsonb, 15
FROM ecommerce.categories c WHERE c.slug = 'processadores'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'be quiet! Fontes Premium Model 1344', 'be-quiet-fontes-premium-model-1344-191', 68.50, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/be-quiet-fontes-premium-model-1344-191/600/400'], '{"brand": "be quiet!"}'::jsonb, 36
FROM ecommerce.categories c WHERE c.slug = 'fontes-de-alimenta-o'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'NZXT Caixas Premium Model 8424', 'nzxt-caixas-premium-model-8424-192', 75.67, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/nzxt-caixas-premium-model-8424-192/600/400'], '{"brand": "NZXT"}'::jsonb, 15
FROM ecommerce.categories c WHERE c.slug = 'caixas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Gigabyte Motherboards Premium Model 2911', 'gigabyte-motherboards-premium-model-2911-193', 179.73, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/gigabyte-motherboards-premium-model-2911-193/600/400'], '{"brand": "Gigabyte"}'::jsonb, 46
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Fractal Design Caixas Premium Model 6643', 'fractal-design-caixas-premium-model-6643-194', 89.10, c.id, 'Chiptec', ARRAY['https://picsum.photos/seed/fractal-design-caixas-premium-model-6643-194/600/400'], '{"brand": "Fractal Design"}'::jsonb, 28
FROM ecommerce.categories c WHERE c.slug = 'caixas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Corsair Fontes Premium Model 6538', 'corsair-fontes-premium-model-6538-195', 216.47, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/corsair-fontes-premium-model-6538-195/600/400'], '{"brand": "Corsair"}'::jsonb, 11
FROM ecommerce.categories c WHERE c.slug = 'fontes-de-alimenta-o'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'AMD Ryzen Processadores Premium Model 3604', 'amd-ryzen-processadores-premium-model-3604-196', 374.46, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/amd-ryzen-processadores-premium-model-3604-196/600/400'], '{"brand": "AMD Ryzen"}'::jsonb, 34
FROM ecommerce.categories c WHERE c.slug = 'processadores'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Sapphire Placas Premium Model 3224', 'sapphire-placas-premium-model-3224-197', 194.70, c.id, 'PCDiga', ARRAY['https://picsum.photos/seed/sapphire-placas-premium-model-3224-197/600/400'], '{"brand": "Sapphire"}'::jsonb, 23
FROM ecommerce.categories c WHERE c.slug = 'placas-gr-ficas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Sapphire Placas Premium Model 3254', 'sapphire-placas-premium-model-3254-198', 333.62, c.id, 'InfoComputer', ARRAY['https://picsum.photos/seed/sapphire-placas-premium-model-3254-198/600/400'], '{"brand": "Sapphire"}'::jsonb, 1
FROM ecommerce.categories c WHERE c.slug = 'placas-gr-ficas'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Intel Core Processadores Premium Model 7752', 'intel-core-processadores-premium-model-7752-199', 553.92, c.id, 'Globaldata', ARRAY['https://picsum.photos/seed/intel-core-processadores-premium-model-7752-199/600/400'], '{"brand": "Intel Core"}'::jsonb, 19
FROM ecommerce.categories c WHERE c.slug = 'processadores'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO ecommerce.products (title, slug, price, category, store_source, images, specs, stock)
SELECT 'Gigabyte Motherboards Premium Model 2753', 'gigabyte-motherboards-premium-model-2753-200', 715.80, c.id, 'PcComponentes', ARRAY['https://picsum.photos/seed/gigabyte-motherboards-premium-model-2753-200/600/400'], '{"brand": "Gigabyte"}'::jsonb, 43
FROM ecommerce.categories c WHERE c.slug = 'motherboards'
ON CONFLICT (slug) DO NOTHING;
