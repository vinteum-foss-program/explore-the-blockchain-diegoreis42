# Only one single output remains unspent from block 123,321. What address was it sent to?

txid_ans="097e521fee933133729cfc34424c4277b36240b13ae4b01fda17756da1848c1e"

blockhash=$(bitcoin-cli getblockhash 123321)


t_ans=$(bitcoin-cli getblock "$blockhash" 2 | jq --arg 'txid_ans' $txid_ans -c '.tx | .[] | select(.hash == $txid_ans)')

echo $t_ans | jq -r '.vout[0].scriptPubKey.address'


# I ran the code below to find the 
# transaction by calling gettxout to each output and saved
# the txid of the transaction to save RPC calls in the 
# CI environment (and avoid the 10s timeout)
#
# echo "$transactions" | jq -c '.[]' | while read -r tx; do
#     txid=$(echo "$tx" | jq -r '.txid')
# 
#     echo "$tx" | jq -c '.vout[]' | while read -r output; do
#         vout=$(echo "$output" | jq -r '.n')
#    
#         txout=$(bitcoin-cli gettxout "$txid" "$vout")
# 
#         if [ -n "$txout" ]; then
#            echo $tx | jq -r
#            echo "$txout" | jq -r 
#             
#         fi
#     done
# done
