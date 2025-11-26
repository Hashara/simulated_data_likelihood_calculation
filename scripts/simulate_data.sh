#!/bin/bash

root_dir="/Users/u7826985/Projects/Nvidia/data"
output_dir="$root_dir/test_simulations_AA"

num_taxa=100
num_sites=100000

iqtree_exec="$root_dir/scripts/iqtree3"
mkdir -p $output_dir

num_trees=10

cd $output_dir

# Simulate a random tree using Alisim

for i in $(seq 1 $num_trees); do
    mkdir -p tree_${i}
    cd tree_${i}
    $iqtree_exec --alisim tree_${i} -m NQ.plant -t RANDOM${num_taxa} --write-all -redo
    rm -rf *.log *.phy tree_${i}.treefile
    cd $output_dir
done

for i in $(seq 1 $num_trees); do
    cd $output_dir/tree_${i}
    # $iqtree_exec --alisim alignment_${num_sites}.phy -m JC -t tree_${i}.full.treefile --length $num_sites --seqtype DNA -redo
    $iqtree_exec --alisim alignment_${num_sites}.phy -m Poisson -t tree_${i}.full.treefile --length $num_sites --seqtype AA -redo
    cd $output_dir
done