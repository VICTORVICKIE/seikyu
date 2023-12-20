<script lang="ts">
	import { PUBLIC_TURSO_DEV_AUTH_TOKEN, PUBLIC_TURSO_DEV_URL } from '$env/static/public';
	import { createClient } from '@libsql/client/web';
	import type { PageData } from './$types';

	export let data: PageData;
	const areas = data.turso;
	let states = [true].concat(new Array(areas.length - 1).fill(false));

	let shop: string;
	let number: string;

	function open_collapse(idx: number) {
		shop = '';
		number = '';
		if (states[idx]) {
			states[idx] = false;
			return;
		} else {
			for (let i = 0; i < states.length; ++i) {
				states[i] = i === idx;
			}
		}
	}

	function add_shop() {
		console.log(area_id, shop, number);
		createClient({
			url: PUBLIC_TURSO_DEV_URL,
			authToken: PUBLIC_TURSO_DEV_AUTH_TOKEN
		});
	}

	$: area_id = states.indexOf(true) + 1;
</script>

<div class="w-full p-2">
	<div class="flex items-center space-x-4 p-4">
		<iconify-icon icon="mdi:storefront-plus-outline" width="32" />
		<span class="flex-auto">Add Shop</span>
	</div>
	<div class="divider !my-0 divider-neutral-500" />
	<div class="relative overflow-x-auto w-full h-[calc(100dvh_-_10rem)] py-2 space-y-4">
		{#each areas as area, i}
			<div
				class:collapse-open={states[i]}
				class="collapse max-h-[calc(100%_-_{area.length *
					5}rem)] rounded-none border border-neutral-500 collapse-arrow bg-base-200"
			>
				<button
					on:click={() => open_collapse(i)}
					class="collapse-title sticky top-0 bg-base-300 border-b border-neutral-500 text-start text-xl font-medium"
				>
					Area {area}
				</button>
				<div class="collapse-content !p-0">
					<div class="list-none">
						<div class="card bg-base-200 shadow-xl items-center">
							<div class="card-body p-4">
								<label class="form-control w-full max-w-xs">
									<div class="label">
										<span class="label-text">Shop Name</span>
									</div>
									<input
										bind:value={shop}
										type="text"
										class="input input-bordered rounded-xl w-full input-sm max-w-xs"
									/>
								</label>
								<label class="form-control w-full max-w-xs">
									<div class="label">
										<span class="label-text">Phone Number</span>
									</div>
									<input
										bind:value={number}
										inputmode="tel"
										type="tel"
										class="input input-bordered rounded-xl w-full input-sm max-w-xs"
									/>
								</label>
								<button
									class="mt-6 btn btn-outline border-base-content border-opacity-50 rounded-xl btn-sm"
									on:click={add_shop}>+ Add</button
								>
							</div>
						</div>
					</div>
				</div>
			</div>
		{/each}
	</div>
</div>
