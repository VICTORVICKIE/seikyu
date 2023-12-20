<script lang="ts">
	import { createEventDispatcher } from 'svelte';
	import { products } from './Store';
	const dispatch = createEventDispatcher();

	export let id: number;
	export let contenteditable: boolean;
	let name = '';
	let rate = '';
	let qty = '';

	export function get_amount() {
		return amount;
	}

	function on_product(e: Event) {
		const { data } = e as InputEvent;
		name = data ?? '';
		const product = $products[id - 1];
		product.name = name;
		dispatch('product', { id });
	}

	function on_amount() {
		const product = $products[id - 1];
		product.qty = +qty ? +qty : 0;
		product.rate = +rate ? +rate : 0;
		product.amount = amount;
		dispatch('amount');
	}

	function on_rate(e: Event) {
		const target = e.target as HTMLTableCellElement;
		rate = target.innerText.trim() ?? '';
	}

	function on_qty(e: Event) {
		const target = e.target as HTMLTableCellElement;
		qty = target.innerText.trim() ?? '';
	}

	function get_next_cell(curr: string) {
		let next: string;
		switch (curr) {
			case `name-${id}`:
				next = `#rate-${id}`;
				break;
			case `rate-${id}`:
				next = `#qty-${id}`;
				break;
			case `qty-${id}`:
				next = `#name-${id + 1}`;
				break;
			default:
				next = `#name-${id}`;
				break;
		}
		let next_element = document.querySelector(next) ?? document.querySelector(`#name-${id}`);
		return next_element as HTMLTableCellElement;
	}

	function focus_next_cell(e: KeyboardEvent) {
		if (e.key !== 'Enter') return;
		const target = e.target as HTMLTableCellElement;
		if (!target.id) return;
		const next_cell = get_next_cell(target.id);
		next_cell.focus();
	}

	function prevent_enter(e: KeyboardEvent) {
		if (e.key === 'Enter') e.preventDefault();
	}

	$: amount = +rate * +qty;
</script>

<th class="outline-none border border-neutral-500 border-separate">{id}</th>
<td
	id="name-{id}"
	class="outline-none border border-neutral-500 focus:border-b-accent border-separate"
	{contenteditable}
	on:input={on_product}
	on:keydown={prevent_enter}
	on:keyup={focus_next_cell}
/>
<td
	id="rate-{id}"
	class="outline-none border border-neutral-500 focus:border-b-accent border-separate"
	{contenteditable}
	inputmode="decimal"
	on:input={on_rate}
	on:input={on_amount}
	on:keydown={prevent_enter}
	on:keyup={focus_next_cell}
/>
<td
	id="qty-{id}"
	class="outline-none border border-neutral-500 focus:border-b-accent border-separate"
	{contenteditable}
	inputmode="decimal"
	on:input={on_qty}
	on:input={on_amount}
	on:keydown={prevent_enter}
	on:keyup={focus_next_cell}
/>
<td class="outline-none border border-neutral-500 border-separate">{amount ? amount : 0}</td>
