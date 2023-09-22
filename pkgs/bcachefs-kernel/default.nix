{ lib
, stdenv
, fetchpatch
, kernel
, commitDate ? "2023-06-28"
# bcachefs-tools stores the expected-revision in:
#   https://evilpiepirate.org/git/bcachefs-tools.git/tree/.bcachefs_revision
# but this does not means that it'll be the latest-compatible revision
, currentCommit ? "e7f62157681d96386dc500609149b9685358a2b0"
, diffHash ? "sha256-sTV5IQfSU5IgGZVerd/PachzeHwxB00NFD9CJmbNggU="
, kernelPatches # must always be defined in bcachefs' all-packages.nix entry because it's also a top-level attribute supplied by callPackage
, argsOverride ? {}
, ...
} @ args:

# NOTE: bcachefs-tools should be updated simultaneously to preserve compatibility
(kernel.override ( args // {
  version = "${kernel.version}-bcachefs-unstable-${commitDate}";

  extraMeta = {
    branch = "master";
    broken = stdenv.isAarch64;
    maintainers = with lib.maintainers; [ davidak Madouura pedrohlc raitobezarius ];
  };

  structuredExtraConfig = with lib.kernel; {
    BCACHEFS_FS = module;
    BCACHEFS_QUOTA = option yes;
    BCACHEFS_POSIX_ACL = option yes;
    BCACHEFS_LOCK_TIME_STATS = option yes;
  };

  kernelPatches = [ {
      name = "bcachefs-${currentCommit}";

      patch = fetchpatch {
        name = "bcachefs-${currentCommit}.diff";
        url = "https://evilpiepirate.org/git/bcachefs.git/rawdiff/?id=${currentCommit}&id2=v${lib.versions.majorMinor kernel.version}";
        sha256 = diffHash;
      };
    } ] ++ kernelPatches;
}))
