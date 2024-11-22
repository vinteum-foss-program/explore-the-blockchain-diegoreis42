# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`

raw=$(bitcoin-cli getrawtransaction 37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517)

decoded=$(bitcoin-cli decoderawtransaction "$raw")

pubkey1=$(echo "$decoded" | jq -r '.vin[0].txinwitness[1]')
pubkey2=$(echo "$decoded" | jq -r '.vin[1].txinwitness[1]') 
pubkey3=$(echo "$decoded" | jq -r '.vin[2].txinwitness[1]')
pubkey4=$(echo "$decoded" | jq -r '.vin[3].txinwitness[1]') 

descriptor="sh(multi(1,$pubkey1,$pubkey2,$pubkey3,$pubkey4))"

descriptor=$(bitcoin-cli -rpcwallet="SchwKatzeWL" getdescriptorinfo "$descriptor" | jq -r '.descriptor')

bitcoin-cli -rpcwallet="SchwKatzeWL" deriveaddresses $descriptor | jq -r '.[0]'

