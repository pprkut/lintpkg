test_suite_name() {
  local suite_name=$(basename ${BATS_TEST_DIRNAME})

  printf "${suite_name}"
}
