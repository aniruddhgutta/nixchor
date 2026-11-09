final: prev: {
  intel-lpmd = prev.intel-lpmd.overrideAttrs (old: {
    # source: https://github.com/intel/intel-lpmd/pull/121
    patches = (old.patches or [ ]) ++ [ ./patches/intel-lpmd-arrowlake-h.patch ];
  });
}
