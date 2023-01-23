BEGIN {
    split(cols,out,",")
}

NR==1 {
    for (i = 1; i <= NF ; i++) {
       # print $i, OFS
       ix[$i] = i  
    }

    # printf "%s\t", "Row"
    for (i=1; i<= length(out); i++) {
        printf "%s\t%s", out[i], OFS
    }
    print ""
}
NR>1 {
    # printf "%s\t", NR
    for (i=1; i<= length(out); i++) {
        # printf "%s", $ix[out[i]]
        printf "%s\t%s", $ix[out[i]], OFS
   }
   print ""
}
