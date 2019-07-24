data "archive_file" "package" {
  count       = local.enabled_count
  type        = "zip"
  source_dir  = var.source_directory
  output_path = "${path.root}/${var.name}.zip"
}
