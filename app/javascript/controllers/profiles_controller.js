import { Controller } from "@hotwired/stimulus"

export default class ProfilesController extends Controller {
  showAllUserLinks() {
    const userLinks = document.getElementById('all_user_links');
    userLinks.style.display = (userLinks.style.display === 'none') ? 'block' : 'none';
    return false;
  }

  showUserAvatarUpdateForm() {
    const userAvatarUpdateForm = document.getElementById('user_avatar_update_form');
    userAvatarUpdateForm.style.display = (userAvatarUpdateForm.style.display === 'none') ? 'block' : 'none';
    return false;
  }

  showUserLinkCreateForm() {
    const userLinkCreateForm = document.getElementById('user_link_create_form');
    userLinkCreateForm.style.display = (userLinkCreateForm.style.display === 'none') ? 'block' : 'none';
    return false;
  }

  showUserNameSurnameUpdateForm() {
    const userNameSurnameUpdateForm = document.getElementById('user_name_surname_update_form');
    userNameSurnameUpdateForm.style.display = (userNameSurnameUpdateForm.style.display === 'none') ? 'block' : 'none';
    return false;
  }

  showUserEmailUpdateForm() {
    const userEmailUpdateForm = document.getElementById('user_email_update_form');
    userEmailUpdateForm.style.display = (userEmailUpdateForm.style.display === 'none') ? 'block' : 'none';
    return false;
  }

  showUserPasswordUpdateForm() {
    const userPasswordUpdateForm = document.getElementById('user_password_update_form');
    userPasswordUpdateForm.style.display = (userPasswordUpdateForm.style.display === 'none') ? 'block' : 'none';
    return false;
  }
}