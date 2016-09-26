output devel_access_key {
  value = "${aws_iam_access_key.mpoc_api.id}"
}

output devel_secret_key {
  value = "${aws_iam_access_key.mpoc_api.secret}"
}
