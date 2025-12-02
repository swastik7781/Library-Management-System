# Enhance contact form
$content = Get-Content 'contact.html' -Raw

# Add enhanced form styles
$formStyles = @'

        /* Enhanced Form Styles */
        .form-input, .form-textarea {
            background: rgba(255, 255, 255, 0.03);
            border: 2px solid var(--border-light);
            color: white;
            padding: 15px 20px;
            border-radius: 12px;
            width: 100%;
            font-size: 1rem;
            font-family: 'Rajdhani', sans-serif;
            transition: all 0.3s ease;
            outline: none;
        }

        .form-input:focus, .form-textarea:focus {
            border-color: var(--primary);
            background: rgba(255, 255, 255, 0.05);
            box-shadow: 0 0 20px rgba(0, 255, 157, 0.2);
            transform: translateY(-2px);
        }

        .form-input::placeholder, .form-textarea::placeholder {
            color: var(--text-muted);
        }

        .form-group label {
            display: block;
            margin-bottom: 10px;
            color: var(--primary);
            font-weight: 600;
            font-size: 0.95rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .form-group label i {
            margin-right: 8px;
            font-size: 1.1rem;
        }

        .form-input:hover, .form-textarea:hover {
            border-color: var(--primary);
        }
'@

if ($content -notmatch 'Enhanced Form Styles') {
    $content = $content -replace '(\s*@keyframes pulse)', "$formStyles`r`n`$1"
}

# Update form labels with icons
$content = $content -replace '<label>Name</label>', '<label><i class="fas fa-user"></i> Your Name</label>'
$content = $content -replace '<label>Email</label>', '<label><i class="fas fa-envelope"></i> Email Address</label>'
$content = $content -replace '<label>Message</label>', '<label><i class="fas fa-comment-dots"></i> Your Message</label>'

# Update placeholders
$content = $content -replace 'placeholder="Your Name"', 'placeholder="Enter your full name..."'
$content = $content -replace 'placeholder="Your Email"', 'placeholder="your.email@example.com"'
$content = $content -replace 'placeholder="How can we help you\?"', 'placeholder="Tell us how we can help you..."'

Set-Content 'contact.html' $content
Write-Host "Enhanced contact.html form successfully!"
