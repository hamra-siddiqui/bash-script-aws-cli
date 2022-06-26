#!/bin/bash

RankHead="Rank"
NameHead="Name"
SymbolHead="Symbol"
CPHead="Current Price(${vs_currency^^})"

null=''
vs_currency=$1
per_page=$2
padding="               "
paddingForList="           "
i=0
if [[ $vs_currency != $null && $per_page != $null ]]
then
    curl -s 'GET' \
    "https://api.coingecko.com/api/v3/coins/markets?vs_currency=$vs_currency&order=market_cap_desc&per_page=$per_page&page=1&sparkline=false" \
    -H 'accept: application/json' | jq . > currency.json

printf "%13s %s %s %s %s %s %s %s\n" "$RankHead" "${padding:${#RankHead}}" "$NameHead" "${padding:${#NameHead}}" "$SymbolHead" "${padding:${#SymbolHead}}" "$CPHead"

    readarray -t currency < <(jq -c '.[]' currency.json)

    for coin in "${currency[@]}"; do
        ((i++))
        Rank=$i
        Name=$(jq .name <<< "$coin" | sed 's/"//g')
        Symbol=$(jq .symbol <<< "$coin" | sed 's/"//g')
        Current_Price=$(jq .current_price <<< "$coin"  | sed 's/"//g')

        printf "%10s%s%s %s %s %s %s %s %s\n" "${paddingWithZero:${#Rank}}" "$Rank" "${padding:${#Rank}}" "$Name" "${padding:${#Name}}" "$Symbol" "${padding:${#Symbol}}" "$Current_Price"

    done
else
    echo "Please pass currency and items per page as an argument"
fi

