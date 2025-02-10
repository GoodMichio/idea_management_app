// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
document.addEventListener('DOMContentLoaded', () => {
  const aiSuggenstionBtn = document.getElementById('ai-suggestion-btn');
  if (aiSuggenstionBtn) {
    aiSuggenstionBtn.addEventListener('click', () => {
      const title = document.querySelector('
      textarea[name="idea[description]"]').value;
    })
  }
})