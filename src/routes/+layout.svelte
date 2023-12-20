<script lang="ts">
	import { page } from '$app/stores';
	import 'iconify-icon';
	import '../app.css';

	// $: console.log('route', $page.url.href);
</script>

<div class="grid grid-rows-[4rem_1fr] h-[100dvh] relative">
	<nav class="navbar bg-base-300 sticky top-0 z-50">
		<div class="flex w-full items-center justify-between bg-base-300">
			<a href="/" class="normal-case text-lg">Saravana Enterprises</a>
			<div class="contents">
				<svelte:component this={$page.data.component} />
			</div>
		</div>
	</nav>

	<main class="bg-base-100 overflow-hidden">
		<slot />
	</main>
</div>
