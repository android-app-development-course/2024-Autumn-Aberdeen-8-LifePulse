import picker from '@ohos.file.picker';

export async function photoPicker() {
  try {
    let PhotoSelectOptions = new picker.PhotoSelectOptions();
    PhotoSelectOptions.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE;
    PhotoSelectOptions.maxSelectNumber = 1;
    let photoPicker = new picker.PhotoViewPicker();
    photoPicker.select(PhotoSelectOptions).then((PhotoSelectResult) => {
      console.info('PhotoViewPicker.select successfully, PhotoSelectResult uri: ' + JSON.stringify(PhotoSelectResult));
    }).catch((err) => {
      console.error('PhotoViewPicker.select failed with err: ' + err);
    });
  } catch (err) {
    console.error('PhotoViewPicker failed with err: ' + err);
  }
}

@Builder function PhotoPicker() {
  Text()
}