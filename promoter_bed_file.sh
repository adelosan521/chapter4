!/bin/bash

# Define promoter region size
promoter_size=1000

# Load genome annotation file
annotation_file="/ceph/project/tunbridgelab/aangeles/atacseq/hipsci/new_annotation.gtf"

# Create BED file for promoter regions
awk -F'\t' '$3 == "gene" {
  if ($7 == "+") {
    promoter_start = $4 - '"$promoter_size"'
    promoter_end = $4
  } else if ($7 == "-") {
    promoter_start = $5
    promoter_end = $5 + '"$promoter_size"'
  } else {
    next
  }
  promoter_id = $1 "_" promoter_start "_" promoter_end "_" $7
  print $1, promoter_start, promoter_end, promoter_id
}' "$annotation_file" | sort -k1,1 -k2,2n > promoter_regions.bed
