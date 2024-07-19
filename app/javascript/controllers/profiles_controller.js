import { Controller } from "@hotwired/stimulus"

export default class ProfilesController extends Controller {
  connect() {
    this.userLinks = document.getElementById('all_user_links');
    this.userAvatarUpdateForm = document.getElementById('user_avatar_update_form');
    this.userLinkCreateForm = document.getElementById('user_link_create_form');
    this.userNameSurnameUpdateForm = document.getElementById('user_name_surname_update_form');
    this.userEmailUpdateForm = document.getElementById('user_email_update_form');
    this.userPasswordUpdateForm = document.getElementById('user_password_update_form');
    this.array = [
      this.userLinks, this.userAvatarUpdateForm, this.userLinkCreateForm,
      this.userNameSurnameUpdateForm, this.userEmailUpdateForm, this.userPasswordUpdateForm
    ];
  }

  showAllUserLinks() {
    this.toggleDisplay(this.userLinks);
    this.hideElements(this.userLinks);
    return false;
  }

  showUserAvatarUpdateForm() {
    this.toggleDisplay(this.userAvatarUpdateForm);
    this.hideElements(this.userAvatarUpdateForm);
    return false;
  }

  showUserLinkCreateForm() {
    this.toggleDisplay(this.userLinkCreateForm);
    this.hideElements(this.userLinkCreateForm);
    return false;
  }

  showUserNameSurnameUpdateForm() {
    this.toggleDisplay(this.userNameSurnameUpdateForm);
    this.hideElements(this.userNameSurnameUpdateForm);
    return false;
  }

  showUserEmailUpdateForm() {
    this.toggleDisplay(this.userEmailUpdateForm);
    this.hideElements(this.userEmailUpdateForm);
    return false;
  }

  showUserPasswordUpdateForm() {
    this.toggleDisplay(this.userPasswordUpdateForm);
    this.hideElements(this.userPasswordUpdateForm);
    return false;
  }

  toggleDisplay(element) {
    element.style.display = (element.style.display === 'none') ? 'block' : 'none';
  }

  hideElements(element) {
    for(let i = 0; i < this.array.length; i++) {
      if (this.array[i] != element) {
        this.array[i].style.display = 'none';
      }
    }
  }
}
