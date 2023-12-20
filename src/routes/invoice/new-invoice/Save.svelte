<script lang="ts">
    function test() {
        const modal = document.getElementById("save_bill") as HTMLDialogElement;
        modal?.showModal();
    }
</script>

<button class="inline-flex" on:click={test}>
    <iconify-icon icon="mdi:check-circle-outline" width="24" />
</button>
