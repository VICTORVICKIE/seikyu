<script lang="ts">
	import type { LayoutData } from './$types';

	export let data: LayoutData;
	const areas = data.turso;
	let states = [true].concat(new Array(areas.length - 1).fill(false));
	let checked: boolean;

	function open_collapse(idx: number) {
		if (states[idx]) {
			states[idx] = false;
			return;
		} else {
			for (let i = 0; i < states.length; ++i) {
				states[i] = i === idx;
			}
		}
	}
</script>

<div class="w-full p-2">
	<div class="flex items-center space-x-4 p-4">
		<iconify-icon icon="mdi:storefront-outline" width="32" />

		<span class="flex-auto"> Need to Add Search Feature Here </span>
	</div>
	<div class="divider !my-0 divider-neutral-500" />
	<div class="relative overflow-x-auto w-full h-[calc(100dvh_-_10rem)] py-2 space-y-4">
		{#each areas as area, i}
			<div
				class:collapse-open={states[i]}
				class="collapse max-h-[calc(100%_-_15rem)] overflow-y-auto rounded-none border border-neutral-500 collapse-arrow bg-base-200"
			>
				<button
					on:click={() => open_collapse(i)}
					class="collapse-title sticky top-0 bg-base-300 border-b border-neutral-500 text-start text-xl font-medium"
				>
					{area}
				</button>
				<div class="collapse-content !p-0">
					<div class="list-none">
						{#each { length: 15 } as _, j}
							<!-- href="/shops/{j}" -->
							<a
								href={'#'}
								class="flex items-center p-4 hover:bg-secondary hover:text-secondary-content"
							>
								<span class="flex-auto">
									<dt class="font-bold">Shop {j}</dt>
								</span>
								<iconify-icon width="24" icon="mdi:chevron-right" />
							</a>
							<div class="divider h-0 !my-0 divider-neutral-500" />
						{/each}
					</div>
				</div>
			</div>
		{/each}
	</div>
</div>
