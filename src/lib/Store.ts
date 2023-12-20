import { writable } from "svelte/store";
import type Product from './Product.svelte';

export interface IProduct {
    id: number;
    component?: Product;
    css?: string;
    last: boolean;
    name?: string;
    rate?: number;
    qty?: number;
    amount?: number
}

export const products = writable<IProduct[]>([]);
