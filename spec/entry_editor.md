# Entry Editor Screen Specification

## 1. Introduction

This document details the technical specifications for the Entry Editor screen in the Mindwell mobile application. The Entry Editor allows users to create new diary entries and edit existing ones.

## 2. Goals

*   Provide a user-friendly and powerful rich text editor for creating and editing entries.
*   Offer a comprehensive set of features, including image insertion, tag management, and privacy settings.
*   Ensure data is saved reliably, with support for both local drafts and server-side publishing.

## 3. Functional Requirements

### 3.1. UI Elements

*   **Layout:** A clean and focused layout with a clear separation between the content editor and the entry settings.
*   **Title Field:** A text field for the entry title.
*   **Content Editor:** A rich text editor powered by the `flutter_quill` package, with a streamlined toolbar for formatting, image insertion, and tag management.
*   **Image Management:**
    *   Images will be displayed inline in the editor, with options to resize, reorder, and delete.
*   **Tag Management:**
    *   Tags will be displayed as chips below the title, with an input field for adding new tags.
*   **Entry Settings:**
    *   A bottom sheet will be used to display and edit the entry settings, including:
        *   Privacy level.
        *   Comment and vote settings.
        *   "Post in Live" and "Allow Sharing" toggles.
        *   "Post Anonymously" toggle (for new entries in themes).
*   **Action Buttons:**
    *   "Preview" icon button to send the entry as draft and preview using the reply.
    *   "Publish" button to publish the entry to the server.
*   **Save Status:** A "last saved" timestamp will be displayed to give users confidence that their work is being saved.

### 3.2. Data Handling

*   **Local Drafts (for new entries):**
    *   New entries will be automatically saved as a local draft every 30 seconds.
    *   The local draft will be stored on the device using a suitable persistence solution (e.g., Hive).
*   **Server-side Publishing:**
    *   The "Publish" button will send the entry data to the server.
    *   New images will be uploaded to the server before the entry is published, with progress indicators for each image.
*   **Editing Existing Entries:**
    *   When editing an existing entry, the data will be fetched from the server and pre-populated in the editor.
    *   There will be no local autosaving when editing an existing entry.

### 3.3. API Interactions

*   `/images` (POST): Upload new images.
*   `/me/tlog` (POST): Create a new entry in the user diary.
*   `/themes/{name}/tlog` (POST): Create a new entry in a theme.
*   `/entries/{id}` (PUT): Update an existing entry.
*   `/entries/{id}` (GET): Get an existing entry for editing.

## 4. Non-Functional Requirements

*   **Performance:** The editor should be responsive and lag-free.
*   **Security:** All data must be transmitted over HTTPS.
*   **Accessibility:** The editor should be accessible to users with disabilities.
*   **Reliability:** Data should be saved reliably, even in the event of network interruptions.

## 5. Flutter Implementation Details

*   **API Client:** Use the generated `EntriesApi`, `ThemesApi`, and `ImagesApi` directly in the provider.
*   **State Management:** Use a `StateNotifierProvider` from `Riverpod`.
*   **Rich Text Editor:** Use the `flutter_quill` package.
*   **Image Picker:** Use the `image_picker` package.
*   **Local Storage:** Use the `hive` package for local draft storage.
*   **Componentization:** Use separate widgets for the editor, image manager, and tag manager.

## 6. State Management

The `StateNotifier` will manage an `EntryEditorState` object, which will be a sealed class with the following states:

*   **`EntryEditorLoading`:** The initial loading state.
*   **`EntryEditorEditing`:** The state when the user is editing the entry.
    *   The entry title and content (as a Quill Delta).
    *   The list of attached images and their states (e.g., `new`, `uploading`, `uploaded`, `deleted`).
    *   The list of tags.
    *   All entry settings (privacy, comments, etc.).
*   **`EntryEditorSaving`:** The state when the entry is being saved as a local draft.
*   **`EntryEditorPublishing`:** The state when the entry is being published to the server.
*   **`EntryEditorError`:** The state when an error occurs.
    *   `String errorMessage`: The error message.

## 7. Accessibility

*   **Semantic Labels:** Provide meaningful semantic labels for all interactive elements, including the editor toolbar buttons, image management controls, and entry settings.
*   **Focus Order:** Ensure that the focus order is logical and that all interactive elements are focusable.
*   **Rich Text Editor Accessibility:** Ensure that the rich text editor is accessible to screen readers, with proper announcements for formatting changes and content updates.

## 8. Error Handling

*   **Image Upload Errors:** Display an error message and a "retry" button for each image that fails to upload.
*   **Publishing Errors:** Display a clear error message if the entry fails to publish, and allow the user to retry.
*   **Local Draft Errors:** Handle potential errors with saving and loading local drafts gracefully.
