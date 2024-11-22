# Which tx in block 257,343 spends the coinbase output of block 256,128?

block_hash_256128=$(bitcoin-cli getblockhash 256128)
coinbase_txid=$(bitcoin-cli getblock $block_hash_256128 2 | jq -r '.tx[0].txid')

block_hash_257343=$(bitcoin-cli getblockhash 257343)
transactions=$(bitcoin-cli getblock $block_hash_257343 2 | jq '.tx')

spending_tx=$(echo "$transactions" | jq --arg coinbase_txid "$coinbase_txid" '
    .[] | select(.vin[].txid == $coinbase_txid)
')

echo "$spending_tx" | jq -r '.txid'
