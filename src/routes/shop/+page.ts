import type { PageLoad } from './$types';
import Shop from './Shop.svelte';
export const load = (async () => {
    return {
        component: Shop,
    };
}) satisfies PageLoad;