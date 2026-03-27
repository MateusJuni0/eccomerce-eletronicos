# PLAN.md - CMTecnologia E-commerce Premium (Componentes PC)
*Versão: 4.0 - Master Blueprint (Orquestração Elite)*

## 🎯 Visão Global
Criar a plataforma de e-commerce de componentes informáticos mais avançada, interativa e premium de Portugal. O objetivo não é apenas vender, mas proporcionar uma experiência imersiva que supere a PCDiga, Globaldata, PcComponentes, Chiptec e InfoComputer em termos de UI/UX.

**Diferenciais Exigidos:**
- **Visual Premium:** Dark Mode nativo (Sikka/Linear design system).
- **Interatividade 3D:** Carrosséis de produtos em 3D que reagem ao scroll e ao rato (React Three Fiber).
- **Ambient UI:** Fundos dinâmicos e fluidos utilizando React Bits.
- **Micro-interações:** Transições suaves de página, botões magnéticos, tilt-cards (Framer Motion).
- **Dados Reais:** Catálogo agregado e tratado com produtos reais das 5 maiores lojas de PT.

---

## 🏗️ Stack Tecnológica (Congelada para Estabilidade)
- **Framework:** Next.js 14.2.18 (App Router) - *Versão fixada para evitar bugs do v15 com R3F.*
- **Frontend Core:** React 18.3.1, Tailwind CSS, Shadcn/UI.
- **Animação & 3D:** Framer Motion, React Three Fiber (v8), Drei, GSAP.
- **Efeitos Visuais:** React Bits (Backgrounds, Text Animations).
- **Backend & DB:** Supabase (PostgreSQL, Auth, Storage).
- **Qualidade de Código:** Biome.js, TypeScript Strict.

---

## 🤖 Delegação de Agentes (Responsabilidades Estritas)

### 1. NERO (Lead Growth & Data Engineer)
**Missão:** População massiva de dados e Media.
- **Tarefas:**
  1. Fazer scraping/ingestão de dados das 5 lojas: Uptechbox, PcComponentes, PCDiga, Globaldata, InfoComputer.
  2. Extrair: Título, Preço, Categoria, Especificações Técnicas (JSON), e **Imagens de Alta Qualidade**.
  3. Estruturar os dados num JSON formatado para o Supabase.

### 2. VALKYRIE (Backend Engineer)
**Missão:** Infraestrutura de Dados e APIs.
- **Tarefas:**
  1. Criar o Schema SQL final no Supabase (`products`, `categories`, `cart`, `orders`, `profiles`).
  2. Configurar Row Level Security (RLS) para proteger dados de utilizadores e encomendas.
  3. Criar a Edge Function para simular o pagamento (MBWay/Stripe mock) e processar o carrinho.
  4. Injetar o JSON massivo do NERO na base de dados.

### 3. NEXUS (Frontend Architect & 3D UI)
**Missão:** A interface "Pixel Perfect" e Funcional. Nenhuma página em branco, tudo clicável.
- **Tarefas:**
  1. **Layout Base:** Navbar sticky com blur, Footer completo, carrinho lateral (Sheet).
  2. **Homepage:** Hero section imersiva com React Bits (fundo animado) + Carrossel 3D de GPUs/CPUs em destaque + Bento Grid de categorias.
  3. **PLP (Product List Page):** Grelha de produtos com filtros laterais funcionais (Preço, Marca, Categoria), com animações de entrada (Framer Motion).
  4. **PDP (Product Detail Page):** Galeria interativa, visualizador 3D do componente (se possível), tabs de especificações detalhadas, botão "Adicionar ao Carrinho" com micro-interação de sucesso.
  5. **Fluxo de Compra:** Carrinho a funcionar (estado global via Zustand) -> Página de Checkout -> Sucesso.

### 4. LÚCIO (QA & Code Debugger)
**Missão:** Zero Erros, 60 FPS Constantes.
- **Tarefas:**
  1. Verificar tipagens (TypeScript) e rodar o Biome.js.
  2. Testar hidratação do Next.js.
  3. Garantir que o canvas 3D não causa quebras de performance (Memory leaks).
  4. **Gate de Aprovação:** O deploy só avança se a pontuação for >= 9.0.

### 5. VULKAN (DevOps)
**Missão:** Entrega para o Mundo.
- **Tarefas:**
  1. Deploy na Vercel com configurações ótimas (`vercel.json`).

---

## 🗺️ Fases de Execução (Master Pipeline)

- **FASE 1: Data Ingestion & DB Setup (NERO + VALKYRIE)**
  - Criação das tabelas no Supabase.
  - Extração massiva das 5 lojas portuguesas e injeção na DB.
  *Checkpoint:* Base de dados populada com centenas de produtos reais.

- **FASE 2: Foundation & Theming (DANTE + NEXUS)**
  - Setup do Next.js 14, Tailwind, Sikka Dark Mode.
  - Instalação de Framer Motion, R3F, React Bits.
  - Estruturação do `three-jsx.d.ts` para evitar erros de tipagem.

- **FASE 3: Core UI & Componentes Funcionais (NEXUS)**
  - Navbar, Footer, Carrinho (Zustand), Grelha de Produtos.
  - Conexão do Frontend ao Supabase (Listar produtos reais da DB).

- **FASE 4: Experiência Premium & 3D (NEXUS)**
  - Hero Canvas com React Bits.
  - Carrossel 3D na Homepage.
  - Micro-interações nos botões e hover states (Tilt cards).

- **FASE 5: Revisão, QA & Deploy (LÚCIO + VULKAN)**
  - Testes de todos os botões e links.
  - Auditoria de performance.
  - Deploy final na Vercel.

---
*Assinatura de Arquitetura:* Dante. Aguarda aprovação do Mateus para iniciar a Fase 1.