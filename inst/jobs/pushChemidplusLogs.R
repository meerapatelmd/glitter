



repo_path <- "~/Desktop/chemidplusLogs/"

output <- glitter::isWorkingTreeClean(repo_path)
if (!output) {
        glitter::add_commit_all(commit_message = "automated push",
                                path_to_local_repo = repo_path)
        glitter::push(repo_path)
}
