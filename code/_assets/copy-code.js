// add copy buttons to code blocks
(function () {
  function createButton() {
    const btn = document.createElement('button');
    btn.className = 'copy-code-btn';
    btn.type = 'button';
    btn.textContent = 'Copier';
    btn.style.cssText = 'position:absolute;right:8px;top:8px;padding:4px 8px;font-size:12px;border-radius:4px;border:1px solid #ccc;background:#fff;cursor:pointer;';
    return btn;
  }

  function wrapPre(pre) {
    const wrapper = document.createElement('div');
    wrapper.style.position = 'relative';
    wrapper.className = 'code-wrapper';
    pre.parentNode.replaceChild(wrapper, pre);
    wrapper.appendChild(pre);
    const btn = createButton();
    wrapper.appendChild(btn);
    btn.addEventListener('click', function () {
      const code = pre.innerText || pre.textContent;
      navigator.clipboard.writeText(code).then(() => {
        btn.textContent = 'Copié !';
        setTimeout(() => btn.textContent = 'Copier', 1500);
      }).catch(() => {
        btn.textContent = 'Erreur';
        setTimeout(() => btn.textContent = 'Copier', 1500);
      });
    });
  }

  function enhance() {
    document.querySelectorAll('pre > code, pre').forEach((el) => {
      let pre = el.tagName.toLowerCase() === 'pre' ? el : el.parentNode;
      if (!pre) return;
      if (pre.parentNode && pre.parentNode.classList && pre.parentNode.classList.contains('code-wrapper')) return;
      wrapPre(pre);
    });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', enhance);
  } else {
    enhance();
  }
})();
