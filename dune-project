(lang dune 3.10)

(name relic-sdk)

(generate_opam_files true)

(source
 (github AoeCenter/relic-sdk))

(authors "Andreas Kr\195\188hlmann")

(maintainers "echo 'YW5kcmVhc0BrcnVobG1hbm4uZGV2Cg==' | base64 -d")

(license MIT)

(documentation https://github.com/AoeCenter/relic-sdk)

(package
 (name relic-sdk)
 (depends
  (ocaml
   (>= 4.14))
  (cohttp-lwt-unix
   (>= 5.3.0))
  (yojson
   (>= 2.1.2))
  (lwt
    (>= 5.7.0))
  (lwt_ssl
   (>= 1.2.0))
  (alcotest
   (and
    :with-test
    (>= 1.3.0)))
  (alcotest-lwt
   (and
    :with-test
    (>= 1.7.0)))
  (bisect_ppx
   (and
    :with-test
    (>= 2.3.0)))
  (ocamlformat
   (and
    :with-dev-setup
    (>= 0.26.1)))
  (base
   (>= v0.12.0))
  dune
  dune-build-info))
