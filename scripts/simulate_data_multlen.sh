#!/bin/bash

root_dir="/Users/u7826985/Projects/Nvidia/data"
output_dir="$root_dir/100taxa_dataset"

num_taxa=100
lengths=(100 1000 10000 100000 1000000 10000000)

iqtree_exec="$root_dir/scripts/iqtree3"
mkdir -p "$output_dir"

cd "$output_dir"

# Simulate a random tree once
$iqtree_exec --alisim base_tree -m NQ.plant -t RANDOM${num_taxa} --write-all -redo
rm -rf *.log *.phy base_tree.treefile

# Generate alignments of different lengths
for len in "${lengths[@]}"; do
    mkdir -p "alignment_${len}"
    cp base_tree.full.treefile "alignment_${len}/tree.full.treefile"
    cd "alignment_${len}"
    $iqtree_exec --alisim alignment_${len} -m JC -t tree.treefile --length $len --seqtype DNA -redo
    # $iqtree_exec --alisim alignment_${len} -m Poisson -t tree.treefile --length $len --seqtype AA -redo

    rm -rf *.log
    cd "$output_dir"
done

# Clean up base tree from root
rm -f base_tree.full.treefile