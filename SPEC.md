# SPEC.md - CMTecnologia E-commerce Premium (Componentes)
*Versão Final - Fonte da Verdade para o Swarm*

## 1. Stack Tecnológica Obrigatória (SEM DESVIOS)
- **Frontend Core:** Next.js 14.2.18 (App Router), React 18.3.1 (NÃO 19).
- **Styling:** Tailwind CSS, Shadcn/UI (Apenas fundação, PROIBIDO usar defaults crus), Lucide Icons.
- **Animações (UX Premium):** Framer Motion, GSAP. Tudo deve ser animado.
- **Interatividade 3D:** `@react-three/fiber` (^8.17.10), `@react-three/drei`, `three`.
- **Efeitos Visuais:** Componentes inspirados no *React Bits* e *Component Forge* (backgrounds dinâmicos, texto animado, physics menus).
- **Backend & Auth:** Supabase (Database PostgreSQL no schema `ecommerce` + RLS).
- **Gestão de Estado:** Zustand (Carrinho de Compras).
- **Qualidade/Lint:** Biome.js, TypeScript Strict (sem `any`).

## 2. Estrutura de Pastas (Monorepo Local)
```text
C:\Users\mjnol\.openclaw\workspace\projects\ecommerce-components\
├── data/               # Scripts e base de dados mockup (204 produtos)
├── supabase/           # Migrations, seed.sql no schema `ecommerce`
└── web_new/            # Aplicação Next.js NEXUS (NOVA PASTA)
    ├── src/app/        # Rotas (page.tsx, layout.tsx, categoria/[slug])
    ├── src/components/ # Componentes (ui, 3d, layout, menus)
    ├── src/lib/        # Utils, Supabase Client, store Zustand
    └── src/types/      # Definições TS, three-jsx.d.ts
```

## 3. Schema de Base de Dados (VALKYRIE)
Tabelas exigidas e já criadas no Supabase (VPS, Schema: `ecommerce`):
- `products`: id, title, slug, price, category, store_source, images (array com min. 3 imgs), specs (jsonb), stock.
- `categories`: id, name, slug (7 nichos exatos criados).
- `orders`: id, user_id, total, status, payment_method.
- `order_items`: order_id, product_id, quantity, price_at_time.

## 4. UI/UX e Arquitetura de Páginas (NEXUS) - NOVA VISÃO "7 NICHOS"
- **Global:** 
  - Dark Mode obrigatório (Sikka Design System / Linear vibe).
  - **Menu de Navegação Premium:** PROIBIDO menu hambúrguer simples. Usar navegação fullscreen animada com Framer Motion ou mega-menu *glassmorphism* com interações físicas/3D. 
  - Footer corporativo unificado com logo e marca "CMTecnologia".
- **`/` (Landing Page Portal):** 
  - NÃO listar os 204 produtos aqui.
  - Funciona como um portal imersivo de entrada. Fundo dinâmico (Shaders / React Bits).
  - Destaca os 7 Nichos de forma interativa (ex: Roda 3D, Bento Grid com Tilt, ou Hover reveal de 3D objects).
- **`/categoria/[slug]` (As 7 Landing Pages Específicas):** 
  - O e-commerce comporta 7 templates visuais distintos, um para cada categoria.
  - *Exemplo Gráficas:* Cores neon/agressivas, Floating GPU em 3D, specs em destaque.
  - *Exemplo Processadores:* Estética cyberpunk/circuitos, brilho azul/laser, dados de performance.
  - O cabeçalho e footer mantêm-se, mas o *hero* e a grelha de produtos adaptam-se à vibe do componente.
  - Os produtos reais dessa categoria são listados aqui (botão "Ver mais" para não sobrecarregar). Cada produto exibe as suas 3 imagens num mini-carrossel ao fazer *hover*.
- **`/produto/[slug]` (PDP):** Galeria interativa das 3+ imagens, modelo 3D genérico associado à categoria, animação fluida de "Add to Cart" (voo para o carrinho).
- **`/checkout`:** Carrinho em sidebar (Slide over com Framer Motion), simulação MBWay.

## 5. Protocolo Multi-Agente (Pipeline SAGA V14)
- **DANTE:** Controla o estado, o `vercel.json` e as dependências críticas (npm install root).
- **NERO / VALKYRIE:** [FASE 1 CONCLUÍDA] Schema `ecommerce` criado e 204 produtos/7 categorias populados na VPS.
- **NEXUS:** Responsável pela pasta `web_new/`. Implementa toda a interface descrita na Secção 4. Foco na extrema qualidade das animações e separação dos 7 templates.
- **LÚCIO:** Corre `npm run build` e validações de lint antes do deploy. Se falhar, LÚCIO cura.
- **VULKAN:** Adiciona `.env` na Vercel e faz o deploy produtivo.

*Todos os agentes reportam retorno em JSON estrito contendo `status`, `artifact_path` e `proof_of_work`.*