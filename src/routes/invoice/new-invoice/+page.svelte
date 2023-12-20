<script lang="ts">
	import { afterNavigate, goto } from '$app/navigation';
	import Bill from '$lib/Bill.svelte';
	import type { AfterNavigate } from '@sveltejs/kit';
	import { onMount } from 'svelte';

	async function save_bill() {
		const dialog = document.getElementById('save_bill') as HTMLDialogElement;

		dialog.close();

		goto('/bill?no=1');
	}

	afterNavigate(({ to }: AfterNavigate) => {
		// console.log(to?.url.searchParams.get('no'));
	});

	let date: string;

	function update_date() {
		let curr_date = new Intl.DateTimeFormat('en-IN', {
			day: '2-digit',
			month: '2-digit',
			year: 'numeric',
			timeZone: 'Asia/Kolkata'
		}).format(new Date());

		if (curr_date !== date) {
			date = curr_date;
		}
		requestAnimationFrame(update_date);
	}
	onMount(() => requestAnimationFrame(update_date));
</script>

<div class="relative">
	<div class="flex p-4 gap-4 flex-col justify-between">
		<div class="flex justify-between">
			<span>Bill No: {1}</span><span>Date: {date}</span>
		</div>
		<div class="form-control w-full">
			<label for="Client" class="label">
				<span class="label-text">To:</span>
			</label>
			<input
				type="text"
				placeholder="Store Name"
				class="input rounded-none border-transparent w-full input-sm focus:border-b-primary-focus focus:outline-none"
			/>
		</div>
	</div>
</div>
<div class="relative overflow-x-auto w-full h-[calc(100dvh_-_13rem)]">
	<Bill contenteditable={true} />
</div>
<dialog id="save_bill" class="modal">
	<div class="modal-box">
		<form method="dialog">
			<button class="btn btn-sm btn-circle btn-ghost absolute right-2 top-2">✕</button>
		</form>
		<h3 class="font-bold text-lg">Hello!</h3>
		<p class="py-4">Press ESC key or click on ✕ button to close</p>
		<button on:click={save_bill} class="btn btn-sm btn-circle">Ok</button>
	</div>
</dialog>
