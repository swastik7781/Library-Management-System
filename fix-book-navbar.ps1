# Fix book-details.html navbar
$content = Get-Content 'book-details.html' -Raw

# Replace old logo with new one
$content = $content -replace '<i class="fas fa-book-reader" style="color: var\(--primary\);"></i>\s*Silicon<span>Lib</span>', '<img src="https://silicon.edugrievance.com/assets/LMS/OSS/logo/20250110083807487.png" alt="Logo">'

# Add centered branding after logo
if ($content -notmatch 'nav-center-brand') {
    $content = $content -replace '(</a>\r?\n\s*)<nav>', "`$1            <div class=`"nav-center-brand`">`r`n                <i class=`"fas fa-book-open nav-book-icon`"></i>`r`n                <span class=`"nav-brand-text`">SILICON LIBRARY</span>`r`n                <i class=`"fas fa-book nav-book-icon`"></i>`r`n            </div>`r`n            `$1<nav>"
}

# Update nav links
$content = $content -replace '<li><a href="books.html" class="nav-link active">Library</a></li>', '<li><a href="student-login.html" class="nav-link">Student</a></li><li><a href="admin-login.html" class="nav-link">Admin</a></li>'

Set-Content 'book-details.html' $content
Write-Host "Updated book-details.html navbar successfully!"
