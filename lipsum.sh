#!/bin/bash

# Generate a content markdownfile with some extra frontmatter (introduction, categories, tags)
# Adapt to your liking

title=$(curl "https://asdfast.beobit.net/api/?type=word" |jq .text|sed 's/\.//')
subtitle=$(curl "https://asdfast.beobit.net/api/?type=word&length=9" |jq .text|sed 's/\.//g')
introduction=$(curl "https://asdfast.beobit.net/api/?type=paragraph&length=1" |jq .text)
clist=("Dolor" "Veritas" "Vino" "Canis" "Terra" "Domus")
tlist=("maecenas" "vitae" "rhoncus" "enim" "donec" "malesuada" "sem" "mollis" "neque" "pharetra" "sed" "cras" "ullamcorper" "semper" "sem" "vitae" "porta" "phasellus" "tincidunt" "tempor" "arcu " "eget" "porttitor" "orci" "vulputate" "amet" "urna" "congue" "volutpat" "sed" "velit" "etiam" "quis" "nibh" "porta" "imperdiet" "risus" "quis" "vehicula" "vivamus" "hendrerit")
tlist=( $(shuf -e "${tlist[@]}") )
body=$(curl "https://jaspervdj.be/lorem-markdownum/markdown.txt?fenced-code-blocks=on&no-wrapping=on")

echo "---"
printf "date: %s\n" "$(date +%Y-%m-%dT%H:%M:%S)"
printf "title: %s\n" "$title"
printf "subtitle: %s\n" "$subtitle"
printf "introduction: %s\n" "$introduction"
printf "categories: [\"%s\"]\n" "$(shuf -e ${clist[@]} -n1)"
printf "tags: [\"%s\",\"%s\",\"%s\",\"%s\"]\n" "${tlist[@]:1:4}"
printf "# header: A header image. If not present, it will default to /some/image.webp\n"
printf "# series: ["none"]\n"
printf "debug: false\n"
printf "ignore: false\n"
printf "draft: false\n"
echo "---"
printf "%s\n" "$body"

