<div class="flex flex-col w-full h-full p-4">
	<h2>Invoices</h2>
	<div class="flex justify-around pt-2">
		<a href="/invoice/new-invoice" class="btn flex flex-col w-36 h-36 btn-neutral">
			<iconify-icon icon="mdi:invoice-add" width="36" />
			New Invoice
		</a>

		<a
			on:click={() => alert('Not Implemented')}
			href={'#'}
			class="btn flex flex-col w-36 h-36 btn-neutral"
		>
			<iconify-icon icon="mdi:invoice" width="36" />
			All Invoices
		</a>
	</div>
	<div class="divider divider-neutral-500 my-2" />
	<h2>Shops</h2>
	<div class="flex justify-around pt-2">
		<a href="/shop/new-shop" class="btn flex flex-col w-36 h-36 btn-neutral">
			<iconify-icon icon="mdi:storefront-plus-outline" width="36" />
			Add Shop
		</a>

		<a href="/shop" class="btn flex flex-col w-36 h-36 btn-neutral">
			<iconify-icon icon="mdi:storefront-outline" width="36" />
			View Shops
		</a>
	</div>
	<div class="divider divider-neutral-500 my-2" />

	<div class="flex m-auto">Make Analytic Widget here</div>
</div>
