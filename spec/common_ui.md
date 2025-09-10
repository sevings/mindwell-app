# Common UI Elements

This document outlines the specifications for common UI elements used throughout the Mindwell mobile application. These elements are designed to provide a consistent and native user experience on both Android and iOS platforms.

## 1. App Bar (Top Bar)

The App Bar (or Top App Bar) is a consistent navigation and branding element that appears at the top of most screens.

### 1.1. General Specifications

*   **Platform Adaptability:** The App Bar should adapt its appearance and behavior to match the native conventions of the platform (Android or iOS).
*   **Consistency:** Maintain a consistent style (color, typography, iconography) across all screens.
*   **Responsiveness:** The App Bar should respond appropriately to user interactions, such as taps on navigation icons or search actions.
*   **Elements:**
    *   Hamburger menu icon (or back arrow).
    *   Title of the current screen.
    *   Optional drop-down menu button (right side, depending on the screen).

### 1.2. Android App Bar

*   **Elevation:** Use a subtle elevation shadow to visually separate the App Bar from the content below.
*   **Theme Integration:** Integrate with the device's theme settings (light or dark mode) to adjust colors accordingly.
*   **Navigation Icon:** A hamburger menu icon (☰) should be used to open the navigation drawer, when available. Otherwise, a back arrow (←) should be displayed for navigating back.
*   **Title:** The title of the current screen should be displayed prominently.
*   **Action Items:** Common actions (e.g., search, create entry) can be displayed as icons on the right side of the App Bar.

### 1.3. iOS Navigation Bar

*   **Translucency:** The Navigation Bar should be translucent, allowing the content below to partially show through.
*   **Blur Effect:** Apply a blur effect to the Navigation Bar's background to enhance readability.
*   **Back Button:** Display a back button ( < ) with the title of the previous screen for hierarchical navigation.
*   **Title:** The title of the current screen should be displayed in the center of the Navigation Bar.
*   **Action Items:** Similar to Android, action items can be displayed as icons on the left or right side of the Navigation Bar.
*   **Large Title (Collapsing Toolbar):** On some screens, such as the Profile Feed, consider using a large, bold title that collapses into a standard-sized title as the user scrolls down. This can be achieved using the `CupertinoSliverNavigationBar` widget.

### 1.4. Common App Bar Elements

*   **Logo:** The Mindwell logo may be displayed in the App Bar on certain screens, such as the home screen.
*   **Search Bar:** A search bar can be integrated into the App Bar, either as a persistent element or as an expandable field that appears when the search icon is tapped.
*   **User Avatar:** A small user avatar can be displayed in the App Bar to provide quick access to the user's profile.

### 1.5. Centralized Design System

To ensure visual consistency and adherence to the DRY principle, a comprehensive design system must be implemented in `lib/src/core/`. This system will define all common UI values, making style adjustments easy and global.

#### 1.5.1. Color System

*   **Primary Colors:**
    *   **Main:** `#ff5e3a` (Mindwell Orange)
    *   **Primary Light:** `#ff7a5c`
    *   **Primary Dark:** `#e54a2a`
*   **Secondary Colors:**
    *   **Purple:** `#7c5ac2`
    *   **Blue:** `#38a9ff`
    *   **Teal:** `#08ddc1`
    *   **Cyan:** `#2aebcb`
    *   **Yellow:** `#ffdc1b`
*   **Neutral Colors:**
    *   **Dark Gray:** `#3f4257`
    *   **Medium Gray:** `#515365`
    *   **Light Gray:** `#888da8`
    *   **Lighter Gray:** `#9a9fbf`
    *   **Background:** `#f8f9fa`
    *   **Surface:** `#ffffff`
*   **Semantic Colors:**
    *   **Success:** `#10b981`
    *   **Warning:** `#f59e0b`
    *   **Error:** `#ef4444`
    *   **Info:** `#3b82f6`
*   **Dark Mode Support:** All colors must have dark mode variants with proper contrast ratios (WCAG AA compliance)

#### 1.5.2. Typography System

*   **Font Family:** Use system fonts with fallbacks:
    *   **Primary:** `Inter` (web), `SF Pro Display` (iOS), `Roboto` (Android)
    *   **Monospace:** `JetBrains Mono`, `SF Mono`, `Roboto Mono`
*   **Type Scale:**
    *   **Display Large:** 57sp, weight: 400
    *   **Display Medium:** 45sp, weight: 400
    *   **Display Small:** 36sp, weight: 400
    *   **Headline Large:** 32sp, weight: 400
    *   **Headline Medium:** 28sp, weight: 400
    *   **Headline Small:** 24sp, weight: 400
    *   **Title Large:** 22sp, weight: 500
    *   **Title Medium:** 16sp, weight: 500
    *   **Title Small:** 14sp, weight: 500
    *   **Body Large:** 16sp, weight: 400
    *   **Body Medium:** 14sp, weight: 400
    *   **Body Small:** 12sp, weight: 400
    *   **Label Large:** 14sp, weight: 500
    *   **Label Medium:** 12sp, weight: 500
    *   **Label Small:** 11sp, weight: 500

#### 1.5.3. Spacing System

*   **Base Unit:** 8dp
*   **Spacing Scale:**
    *   **xs:** 4dp
    *   **sm:** 8dp
    *   **md:** 16dp
    *   **lg:** 24dp
    *   **xl:** 32dp
    *   **xxl:** 48dp
    *   **xxxl:** 64dp

#### 1.5.4. Component Themes

*   **AppBar Theme:** Consistent elevation, color, and typography
*   **Button Themes:** Primary, secondary, text, and icon button variants
*   **Card Theme:** Consistent elevation, corner radius, and padding
*   **Input Decoration:** Consistent border, label, and error styling
*   **Material You (Android):** Integrate `dynamic_color` package for Android 12+ adaptive theming

#### 1.5.5. Animation System

*   **Duration Standards:**
    *   **Fast:** 150ms (micro-interactions)
    *   **Normal:** 300ms (standard transitions)
    *   **Slow:** 500ms (complex animations)
*   **Easing Curves:**
    *   **Standard:** `Curves.easeInOut`
    *   **Decelerate:** `Curves.decelerate`
    *   **Accelerate:** `Curves.accelerate`
    *   **Bounce:** `Curves.elasticOut`

## 2. Navigation Drawer/Menu

The Navigation Drawer (Android) or Menu (iOS) provides access to the app's main sections and settings, adapting based on whether the user is logged in or not.

### 2.1. General Specifications

*   **Accessibility:** Ensure that the navigation elements are accessible to users with disabilities, including proper screen reader support and keyboard navigation.
*   **Organization:** Organize the navigation items logically and prioritize the most frequently accessed sections.

### 2.2. Android Navigation Drawer

*   **Appearance:** The Navigation Drawer should slide in from the left edge of the screen, overlaying the main content.
*   **Profile Header:** Include a profile header at the top of the drawer, displaying the user's avatar, name, and email address (if available).
*   **Navigation Items:** List the main sections of the app (e.g., Entry Feed, Profile, Settings) as tappable items in the drawer.
*   **Theme Integration:** Adapt colors to match the device's theme settings.
*   **Logged-in State:**
    *   User name with avatar and cover.
    *   New entry.
    *   My entries.
    *   Subscriptions.
    *   Live.
    *   Best.
    *   Tlogs.
    *   Themes.
    *   Splitter.
    *   Settings.
    *   Help (opens website link).
    *   News (opens 'mindwell' user profile entries).
    *   Rules (opens website link).
    *   About.
*   **Logged-out State:**
    *   Login.
    *   Register.
    *   Live.
    *   Best.
    *   Splitter.
    *   Settings.
    *   Help (opens website link).
    *   News (opens 'mindwell' user profile entries).
    *   Rules (opens website link).
    *   About.

### 2.3. iOS Menu (Bottom Sheet/Side Menu)

*   **Bottom Sheet:** A bottom sheet that slides up from the bottom of the screen, especially for smaller menus.
*   **Side Menu:** A side menu that slides in from the left, similar to the Android Navigation Drawer.
*   **Appearance:** Style the menu items to match the iOS design language (e.g., using system icons and fonts).
*   **Profile Header:** Include a profile header similar to the Android version.

### 2.4. Common Navigation Items

*   **Entry Feed:** Navigate to the main entry feed.
*   **Profile:** Navigate to the user's profile screen.
*   **Settings:** Navigate to the settings screen.
*   **Help/About:** Access help documentation or information about the app.
*   **Logout:** Allow the user to log out of the app.

## 3. Bottom Navigation Bar

A Bottom Navigation Bar provides quick access to a small number of top-level sections, but is only visible when the user is logged in.

### 3.1 General Specifications

*   **Visibility:** The bottom navigation bar should be visible on most main screens of the application.
*   **Number of Items:** Should contain 3-5 destination items.
*   **Iconography:** Each destination should have a clear and recognizable icon.
*   **Logged-in State:**
    *   Icons for common app navigation (entry feeds, user profiles, etc.).
    *   Notifications.
    *   Chats.
*   **Logged-out State:**
    *   Not displayed.

### 3.2. Android Bottom Navigation Bar

*   **Material Design:** Adhere to Material Design guidelines for the bottom navigation bar.
*   **Active State:** Use a clear visual cue (e.g., a filled icon and label) to indicate the currently selected destination.

### 3.3. iOS Tab Bar

*   **Appearance:** Style the tab bar to match the iOS design language using the `CupertinoTabBar` widget.
*   **Active State:** Use a clear visual cue (e.g., a tinted icon) to indicate the currently selected tab.

## 4. Buttons

Buttons are interactive elements that trigger actions when tapped.

### 4.1. General Specifications

*   **Visual Feedback:** Provide visual feedback when a button is tapped (e.g., a slight change in color or elevation).
*   **Accessibility:** Ensure that buttons are accessible to users with disabilities.
*   **States:** Should have states for enabled, disabled, pressed, and focused.

### 4.2. Common Button Types

*   **Primary Button:** Used for the main action on a screen (e.g., "Save," "Submit"). Should have a prominent appearance.
*   **Secondary Button:** Used for less important actions (e.g., "Cancel," "Learn More"). Should have a less prominent appearance than primary buttons.
*   **Text Button:** A simple button with text as its label.
*   **Icon Button:** A button with an icon as its label.

## 5. Text Fields

Text fields allow users to input text.

### 5.1. General Specifications

*   **Clear Labeling:** Each text field should have a clear and concise label indicating its purpose.
*   **Validation:** Implement client-side validation to provide immediate feedback to the user if the input is invalid.
*   **Keyboard Type:** Use the appropriate keyboard type for the input (e.g., email, number, password).

## 6. Loaders and Progress Indicators

Used to indicate that the application is loading data or performing a task.

*   **Types:** Determinate (shows progress) and Indeterminate (shows that something is loading).
*   **Placement:** Should be placed in the center of the screen or inline within the element that is loading.
*   **Skeleton Loaders:** For a more polished user experience, use skeleton loaders (e.g., using the `shimmer` package) instead of a simple `CircularProgressIndicator` when loading content like feeds or profiles. A skeleton loader shows a placeholder preview of the UI, which makes the app feel faster and more responsive.

## 7. Image Handling

Displaying and uploading images needs to be handled gracefully.

*   **Placeholders:** Display placeholder images while the actual image is loading.
*   **Error Handling:** Display error messages if an image fails to load.
*   **Compression:** Compress images before uploading to reduce bandwidth usage.
*   **Aspect Ratio:** Maintain the correct aspect ratio when displaying images.

## 8. Alerts and Dialogs

Used to display important information or to ask the user for confirmation.

*   **Alerts:** Used for simple notifications.
*   **Dialogs:** Used for more complex interactions, such as confirmations or choices.

## 9. Animations and Transitions

Standardize animations and transitions to ensure a consistent and polished user experience.

*   **Page Transitions:** Use subtle and consistent page transitions (e.g., slide, fade) throughout the app.
*   **UI Element Animations:** Animate the appearance of UI elements (e.g., fade in, slide up) to create a more dynamic and engaging interface.
*   **Lottie Animations:** Use Lottie animations for complex animations, such as onboarding screens or success indicators.

## 10. Error States

Design consistent and user-friendly error states for different UI components.

*   **Text Fields:** Display a clear error message below the text field when the input is invalid.
*   **Lists:** Display a full-screen error message with a "Retry" button when a list fails to load.
*   **Inline Errors:** For less critical errors, display an inline error message within the UI component.
*   **Network Errors:** Show specific messaging for different network conditions (no internet, server error, timeout).
*   **Validation Errors:** Provide immediate feedback with clear, actionable error messages.

## 11. Accessibility (a11y) Guidelines

### 11.1. General Accessibility Principles

*   **WCAG 2.1 AA Compliance:** All UI components must meet WCAG 2.1 AA standards
*   **Screen Reader Support:** All interactive elements must be properly labeled
*   **Keyboard Navigation:** All functionality must be accessible via keyboard
*   **Color Contrast:** Minimum 4.5:1 contrast ratio for normal text, 3:1 for large text
*   **Focus Management:** Clear focus indicators and logical tab order

### 11.2. Semantic Labels and Roles

*   **Interactive Elements:** All buttons, links, and form controls must have semantic labels
*   **Content Structure:** Use proper heading hierarchy (h1, h2, h3, etc.)
*   **List Structure:** Use proper list markup for grouped content
*   **Form Labels:** All form inputs must have associated labels
*   **Image Alt Text:** All images must have descriptive alternative text

### 11.3. Focus Management

*   **Focus Indicators:** Visible focus indicators for all interactive elements
*   **Focus Order:** Logical tab order that follows visual layout
*   **Focus Trapping:** Trap focus within modals and dialogs
*   **Skip Links:** Provide skip links for main content areas

### 11.4. Motion and Animation

*   **Respect Preferences:** Honor `prefers-reduced-motion` system setting
*   **Essential Motion Only:** Ensure animations don't interfere with functionality
*   **Alternative Feedback:** Provide non-motion feedback for users who prefer reduced motion

## 12. Component Library Specifications

### 12.1. Button Components

*   **Primary Button:** Main action button with solid background
*   **Secondary Button:** Secondary action with outlined style
*   **Text Button:** Minimal button for less important actions
*   **Icon Button:** Button with icon only, must have tooltip
*   **Floating Action Button:** Circular button for primary actions
*   **Loading States:** Show loading indicators during async operations

### 12.2. Input Components

*   **Text Field:** Standard text input with label and validation
*   **Password Field:** Text input with visibility toggle
*   **Search Field:** Text input with search icon and clear button
*   **Text Area:** Multi-line text input for longer content
*   **Select Field:** Dropdown selection with search capability
*   **Date Picker:** Date selection with calendar interface

### 12.3. Display Components

*   **Card:** Container for related content with consistent styling
*   **Avatar:** User profile image with fallback initials
*   **Badge:** Small status indicator or notification count
*   **Chip:** Compact element for tags or filters
*   **Divider:** Visual separator between content sections
*   **Progress Indicator:** Loading or progress visualization

### 12.4. Navigation Components

*   **App Bar:** Top navigation with title and actions
*   **Bottom Navigation:** Primary navigation tabs
*   **Drawer:** Side navigation menu
*   **Breadcrumb:** Hierarchical navigation path
*   **Pagination:** Page navigation for lists
*   **Tab Bar:** Content section navigation

### 12.5. Feedback Components

*   **Snackbar:** Brief message at bottom of screen
*   **Toast:** Temporary notification message
*   **Dialog:** Modal overlay for important interactions
*   **Bottom Sheet:** Slide-up panel for secondary actions
*   **Tooltip:** Contextual help text on hover/focus
*   **Alert:** Important message with action buttons

## 13. Responsive Design Guidelines

### 13.1. Breakpoints

*   **Mobile:** < 600dp (single column)
*   **Tablet:** 600dp - 1024dp (two columns)
*   **Desktop:** > 1024dp (three columns)
*   **Large Desktop:** > 1440dp (four columns)

### 13.2. Layout Adaptations

*   **Grid Systems:** Responsive grid that adapts to screen size
*   **Navigation:** Collapsible navigation on smaller screens
*   **Content Density:** Adjust content spacing based on screen size
*   **Touch Targets:** Minimum 44dp touch targets on mobile

This document will be updated as the application evolves and new common UI elements are introduced.
