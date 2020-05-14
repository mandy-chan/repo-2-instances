
# # Use local_dependency: To enable referencing of another project
# # on this instance with include: statements
#
# local_dependency: {
#   project: "name_of_other_project"
# }

constant: bigquery_dataset {
  value: "Analytics_v2"
  export: override_optional
}
