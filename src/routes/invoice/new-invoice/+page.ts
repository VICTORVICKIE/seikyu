import type { PageLoad } from './$types';
import Save from './Save.svelte';

export const load = (() => {
    return {
        component: Save
    };
}) satisfies PageLoad;