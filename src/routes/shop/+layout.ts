import { PUBLIC_TURSO_DEV_AUTH_TOKEN, PUBLIC_TURSO_DEV_URL } from '$env/static/public';
import { createClient } from "@libsql/client/web";
import type { LayoutLoad } from './$types';

export const load = (async () => {

    const client = createClient({
        url: PUBLIC_TURSO_DEV_URL,
        authToken: PUBLIC_TURSO_DEV_AUTH_TOKEN
    });

    const rs = await client.execute("SELECT name FROM Area ORDER BY id");
    const result: string[] = []
    for (const rows of rs.rows) {
        result.push(rows.name as string)
    }

    return {
        turso: result
    };
}) satisfies LayoutLoad;