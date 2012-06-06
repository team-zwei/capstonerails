$("#auction_category").chosen();

$("#upload_form").validate({
  rules: {
    'submission[movie]': {
      required: true,
      accept: "avi|mov|mp4|m4v|mpg"
    }
  },
  messages: {
    'submission[movie]': "Please choose a .avi, .mov, .mp4, .m4v, or .mpg file."
  }
})