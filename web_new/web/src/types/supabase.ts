export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export interface Database {
  public: {
    Tables: {
      products: {
        Row: {
          id: string
          title: string
          slug: string
          price: number
          category: string
          store_source: string
          images: string[]
          specs: Json
          stock: number
          created_at: string
        }
        Insert: {
          id?: string
          title: string
          slug: string
          price: number
          category: string
          store_source?: string
          images?: string[]
          specs?: Json
          stock?: number
          created_at?: string
        }
        Update: {
          id?: string
          title?: string
          slug?: string
          price?: number
          category?: string
          store_source?: string
          images?: string[]
          specs?: Json
          stock?: number
          created_at?: string
        }
      }
      categories: {
        Row: {
          id: string
          name: string
          slug: string
        }
      }
    }
  }
}