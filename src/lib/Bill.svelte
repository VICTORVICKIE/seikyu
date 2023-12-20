<script lang="ts">
    import { onMount, tick } from "svelte";
    import Product from "./Product.svelte";
    import { products, type IProduct } from "./Store";

    export let contenteditable: boolean;
    onMount(initialize);
    let total = 0;

    function initialize() {
        if ($products.length) return;
        let p: IProduct = {
            id: 1,
            last: true,
            css: "print:hidden",
        };
        $products.push(p);

        $products = $products;
    }

    async function new_product({ detail }: CustomEvent) {
        const idx = detail.id - 1;
        const product = $products[idx];

        if (product.last) {
            product.last = false;
            product.css = "";
            let p: IProduct = {
                id: detail.id + 1,
                last: true,
                css: "print:hidden",
            };
            $products.push(p);
            $products = $products;
            await tick();
        }
    }

    async function calc_total() {
        total = 0;
        for (let idx = 0; idx < $products.length; ++idx) {
            const amount = $products[idx].amount;
            if (amount) {
                total += amount;
            } else {
                total += 0;
            }
        }
        await tick();
    }
</script>

<table
    class="table rounded-none table-pin-rows table-pin-cols text-center bg-base-100 border-separate border border-neutral-500"
>
    <thead
        class="text-error bg-base-100 border-separate border border-neutral-500"
    >
        <tr>
            <th class="border-separate border border-neutral-500">No.</th>
            <td class="border-separate border border-neutral-500">Product</td>
            <td class="border-separate border border-neutral-500">Rate</td>
            <td class="border-separate border border-neutral-500">Qty</td>
            <td class="border-separate border border-neutral-500">Amount</td>
        </tr>
    </thead>
    <tbody>
        {#each $products as p (p.id)}
            <tr class={p.css}>
                <Product
                    {contenteditable}
                    bind:this={p.component}
                    id={p.id}
                    on:product={new_product}
                    on:amount={calc_total}
                />
            </tr>
        {/each}
    </tbody>
    <tfoot class="text-left">
        <tr>
            <td
                class="border-separate border-t border border-neutral-500"
                colspan="4"
            />
            <td class="border-separate border-t border border-neutral-500"
                >Total Amount: {total}</td
            >
        </tr>
    </tfoot>
</table>
